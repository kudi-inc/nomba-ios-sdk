//
//  CardView.swift
//
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import SwiftUI
import Drops

struct CardView: View {
    @State var logo : Image?
    var roundPadding : CGFloat = 15
    @Environment(\.presentationMode) var presentationMode
    @Binding var parentPresentationMode : PresentationMode
    @Binding var paymentOptionsViewModel : PaymentOptionsViewModel
    @State var isLoading = false
    @State var cardPaymentStatus : CardPaymentStatus = .DETAILS
    @State var isSuccessViewShowing = false
    @State var isShowingCancelDialog = false
    @State var creditCardNumber : String = ""
    @State var creditCardExpDate : String = ""
    @State var creditCardCCV : String = ""
    @State var cardPin : String = ""
    @State var saveCard = false
    @State var otpMessage : String = "Enter the One Time Password (OTP)\n sent to **** *** **87 to verify it"
    
    @State var transactionID : String = ""
    @State var acsUrl : String = ""
    @State var jwtToken : String = ""
    @State var md : String = ""
    @State var termUrl : String = ""
    
    var body: some View {
        ZStack{
            VStack{
                TopView(logo: logo)
                switch (cardPaymentStatus) {
                case .DETAILS:
                    CardDetailsView(creditCardNumber: $creditCardNumber, creditCardExpDate: $creditCardExpDate, creditCardCCV: $creditCardCCV, saveCard: $saveCard, cancelPayment: cancelPayment, onPayButtonAction: onPayButtonAction)
                case .CARD_LOADING:
                    CardLoadingView()
                case .CARD_PIN:
                    CardPinView(cardPin: $cardPin, onPinEnteredAction: onPinEnteredAction)
                case .CARD_OTP:
                    CardOTPView(otpMessage: $otpMessage)
                case .CARD_3DS:
                    Card3DSView(acsUrl: $acsUrl, jwtToken: $jwtToken, md: $md, termUrl: $termUrl, on3DSSuccessAction: on3DSSuccessAction)
                }
                Spacer()
                FooterView()
            }
            .padding(roundPadding)
            .font(.custom(FontsManager.fontRegular, size: 14))
            .foregroundStyle(Color("Text Primary", bundle: .module))
            if (isLoading){
                LoaderView()
            }
        }.sheet(isPresented: $isSuccessViewShowing){
            CardSuccessView(parentPresentationMode: $parentPresentationMode, saveCard: $saveCard).interactiveDismissDisabled(true)
        }.sheet(isPresented: $isShowingCancelDialog){
            if #available(iOS 16.4, *) {
                CancelPaymentConfirmationView(parentPresentationMode: presentationMode).presentationDetents([.height(340)])
                    .presentationDragIndicator(.hidden)
                    .presentationCornerRadius(21)
            } else {
                // Fallback on earlier versions
                CancelPaymentConfirmationView(parentPresentationMode: presentationMode)
                    .presentationDetents([.height(340)])
                    .presentationDragIndicator(.hidden)
            }
        }
    }
    
    func cancelPayment(){
        isShowingCancelDialog = true
    }
    
    func onPayButtonAction(){
        cardPaymentStatus = .CARD_PIN
    }
    
    func on3DSSuccessAction(){
        cardPaymentStatus = .CARD_LOADING
        checkTransactionStatus()
    }
    
    func checkTransactionStatus() {
        paymentOptionsViewModel.checkTransactionOrderStatus(completion: { result in
            switch result {
            case .success(let data):
                if (data.code == "00" && data.data.status == "true"){
                    //show success
                    isSuccessViewShowing = true
                }
            case .failure(_):
                break
            }
        })
    }
    
    func onPinEnteredAction() {
        hideKeyboard()
        cardPaymentStatus = .CARD_LOADING
        let year = Util.getDateComponents(isoDate: creditCardExpDate).year ?? 2024
        let month = Util.getDateComponents(isoDate: creditCardExpDate).month ?? 12
        paymentOptionsViewModel.submitcardDetails(cardNumber: creditCardNumber.trimmingCharacters(in: CharacterSet.whitespaces).replacingOccurrences(of: " ", with: ""),
                                                  cardExpMonth: String(describing: month),
                                                  cardExpYear: String(describing: year),
                                                  cvv: creditCardCCV,
                                                  cardPin: cardPin,
                                                  saveCard: saveCard, completion: {result in
            switch result {
            case .success(let data):
                if (data.code == "00" && data.data.responseCode == "T0"){
                    // regular OTP
                    otpMessage = data.data.message
                    transactionID = data.data.transactionID
                    cardPaymentStatus = .CARD_OTP
                } else if (data.code == "00" && data.data.responseCode == "S0"){
                    // 3DS
                    acsUrl = data.data.secureAuthenticationData?.acsURL ?? ""
                    jwtToken = data.data.secureAuthenticationData?.jwt ?? ""
                    md = data.data.secureAuthenticationData?.md ?? ""
                    termUrl = data.data.secureAuthenticationData?.termURL ?? ""
                    cardPaymentStatus = .CARD_3DS
                }
            case .failure(let error):
                cardPaymentStatus = .DETAILS
                if (Octane.errorString.isEmpty) {
                    let errorString = "Something went wrong. Try again" + error.localizedDescription
                    Drops.show(Util.getDrop(message: errorString))
                } else {
                    let errorString = Octane.errorString
                    Drops.show(Util.getDrop(message: errorString))
                }
            }
        })
        
    }
}

#Preview {
    @Environment(\.presentationMode) var presentationMode
    return CardView(presentationMode: _presentationMode, parentPresentationMode: presentationMode, paymentOptionsViewModel: .constant(PaymentOptionsViewModel()))
}
