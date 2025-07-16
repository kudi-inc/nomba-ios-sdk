//
//  PaymentsOptionsView.swift
//
//
//  Created by Bezaleel Ashefor on 11/06/2024.
//

import SwiftUI
import Drops

struct PaymentsOptionsView: View {
    @State var logo : Image?
    @State var accountId : String
    @State var clientId : String
    var roundPadding : CGFloat = 15
    
    @State var isLoading = false
    @State var isShowingTransfer = false
    @State var isShowingCard = false
    @State var isShowingCancelDialog = false
    @Environment(\.presentationMode) var presentationMode
    @State var paymentOptionsViewModel = PaymentOptionsViewModel()
    
    @State var accountNumber : String = ""
    @State var bankName : String = "Nombank MFB"
    @State var accountName : String = ""
    @State var showBackArrow = false
    
    var body: some View {
        ZStack{
            VStack{
                TopView(showBackArrow: $showBackArrow, logo: logo)
                VStack(spacing: 0){
                    VStack{
                        Text("Choose any of the payment methods\nbelow to pay").lineSpacing(2)
                    }
                    .padding(.vertical, 20)
                    .padding(.horizontal, 18)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("Neutral Two", bundle: Bundle.module))
                    Button(action: {
                        showTransferView()
                    }){
                        HStack{
                            Image("transfer", bundle: Bundle.module)
                            Text("Pay by Transfer")
                            Spacer()
                            Image("chevron-right", bundle: .module)
                        }.padding(.vertical, 15)
                            .padding(.horizontal, 18)
                    }
                    Divider()
                    Button(action: {
                        showCardView()
                    }){
                        HStack{
                            Image("card", bundle: Bundle.module)
                            Text("Pay by Card")
                            Spacer()
                            Image("chevron-right", bundle: .module)
                        }.padding(.vertical, 15)
                            .padding(.horizontal, 18)
                    }
                }.frame(maxWidth: .infinity, alignment: .leading).background(Color("Neutral One", bundle: Bundle.module))
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                Spacer().frame(height: 50)
                BorderButton(buttonText: "Cancel Payment", action: {
                    isShowingCancelDialog = true
                })
                Spacer()
                FooterView()
            }
            .padding(roundPadding)
            .font(.custom(FontsManager.fontRegular, size: 14))
            .foregroundStyle(Color("Text Primary", bundle: .module))
            if (isLoading){
                LoaderView()
            }
        }.sheet(isPresented: $isShowingTransfer){
            TransferView(logo: logo, accountNumber: accountNumber, bankName: bankName, accountName: accountName, transferPaymentStatus: accountNumber.isEmpty ? .ERROR:.DETAILS, paymentOptionsViewModel: $paymentOptionsViewModel, parentPresentationMode: presentationMode )
                .interactiveDismissDisabled(true)
        }.sheet(isPresented: $isShowingCard) {
            CardView(logo: logo, parentPresentationMode: presentationMode, paymentOptionsViewModel: $paymentOptionsViewModel).interactiveDismissDisabled(true)
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
        }.background(Color.white.ignoresSafeArea())
    }
    
    private func showTransferView(){
        if Octane.orderReference.isEmpty {
            Drops.show("Order reference cannot be empty. Please try again")
            return
        }
        isLoading = true
        paymentOptionsViewModel.createOrder(accountId: accountId,clientId: clientId, amount: "\(Octane.shared.getAmountFormated())", customerEmail: Octane.email, currency: "NGN", selectedPaymentOption: .TRANSFER, completion: { result in
            switch result {
            case .success(let data):
                if (data){
                    isLoading = false
                    accountName = paymentOptionsViewModel.accountName
                    accountNumber = paymentOptionsViewModel.accountNumber
                    bankName = paymentOptionsViewModel.bankName
                    isShowingTransfer = true
                } else {
                    if (Octane.errorString.isEmpty) {
                        Drops.show("Something went wrong. Try again")
                    } else {
                        let errorString = Octane.errorString
                        Drops.show(Util.getDrop(message: errorString))
                    }
                    isLoading = false
                }
            case .failure(let error):
                let errorString : String = error.localizedDescription
                Drops.show(Util.getDrop(message: errorString))
                isLoading = false
            }
        })
    }
    
    private func showCardView(){
        if Octane.orderReference.isEmpty {
            Drops.show("Order reference cannot be empty. Please try again")
            return
        }
        isLoading = true
        paymentOptionsViewModel.createOrder(accountId: accountId,clientId: clientId, amount: "\(Octane.shared.getAmountFormated())", customerEmail: Octane.email, currency: "NGN", selectedPaymentOption: .CARD, completion: { result in
            switch result {
            case .success(let data):
                if (data){
                    isLoading = false
                    accountName = paymentOptionsViewModel.accountName
                    accountNumber = paymentOptionsViewModel.accountNumber
                    bankName = paymentOptionsViewModel.bankName
                    isShowingCard = true
                } else {
                    if (Octane.errorString.isEmpty) {
                        Drops.show("Something went wrong. Try again")
                    } else {
                        let errorString = Octane.errorString
                        Drops.show(Util.getDrop(message: errorString))
                    }
                    isLoading = false
                }
            case .failure(let error):
                let errorString : String = error.localizedDescription
                Drops.show(Util.getDrop(message: errorString))
                isLoading = false
            }
        })
    }
    
    
}

#Preview {
    PaymentsOptionsView(accountId: "", clientId: "").onAppear{
        //Octane.shared.configure(clientId: "", accountId: "", clientKey: "")
    }
    
}
