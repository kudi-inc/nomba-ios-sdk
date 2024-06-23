//
//  CardView.swift
//
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import SwiftUI

struct CardView: View {
    @State var logo : Image?
    var roundPadding : CGFloat = 15
    @Environment(\.presentationMode) var presentationMode
    @Binding var parentPresentationMode : PresentationMode
    @State var isLoading = false
    @State var cardPaymentStatus : CardPaymentStatus = .DETAILS
    @State var isSuccessViewShowing = false
    @State var isShowingCancelDialog = false
    @State var creditCardNumber : String = ""
    @State var creditCardExpDate : String = ""
    @State var creditCardCCV : String = ""
    @State var saveCard = false
    
    var body: some View {
        ZStack{
            VStack{
                TopView(logo: logo)
                switch (cardPaymentStatus) {
                case .DETAILS:
                    CardDetailsView(creditCardNumber: $creditCardNumber, creditCardExpDate: $creditCardExpDate, creditCardCCV: $creditCardCCV, saveCard: $saveCard, cancelPayment: cancelPayment)
                case .CARD_LOADING:
                    CardLoadingView()
                case .CARD_PIN:
                    CardPinView()
                case .CARD_OTP:
                    CardOTPView()
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
                CancelPaymentConfirmationView(parentPresentationMode: presentationMode).presentationDetents([.height(340)])
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
}

#Preview {
    @Environment(\.presentationMode) var presentationMode
    return CardView(presentationMode: _presentationMode, parentPresentationMode: presentationMode)
}
