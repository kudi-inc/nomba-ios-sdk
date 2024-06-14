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
    @State var clientKey : String
    var roundPadding : CGFloat = 15
    
    @State var isLoading = false
    @State var isShowingTransfer = false
    @State var isShowingCard = false
    @Environment(\.presentationMode) var presentationMode
    var paymentOptionsViewModel = PaymentOptionsViewModel()
    
    @State var accountNumber : String = "98762371891"
    @State var bankName : String = "Amucha MFB"
    @State var accountName : String = "Abdullahi Abodunrin"
    
    var body: some View {
        ZStack{
            VStack{
                TopView(logo: logo)
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
                    presentationMode.wrappedValue.dismiss()
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
            TransferView(accountNumber: accountNumber, bankName: bankName, accountName: accountName)
        }.sheet(isPresented: $isShowingCard) {
            
        }
    }
    
    private func showTransferView(){
        isLoading = true
        paymentOptionsViewModel.getAccessToken(accountId: accountId, clientId: clientId, clientKey: clientKey, selectedPaymentOption: .TRANSFER, completion: { result in
            switch result {
            case .success(let data):
                if (data){
                    paymentOptionsViewModel.createOrder(accountId: accountId, amount: "\(Octane.shared.getAmountFormated())", customerEmail: Octane.email, currency: "NGN", selectedPaymentOption: .TRANSFER, completion: { result in
                        switch result {
                        case .success(let data):
                            if (data){
                                isLoading = false
                                accountName = paymentOptionsViewModel.accountName
                                accountNumber = paymentOptionsViewModel.accountNumber
                                bankName = paymentOptionsViewModel.bankName
                                isShowingTransfer = true
                            } else {
                                Drops.show("Something went wrong. Try again")
                                isLoading = false
                            }
                        case .failure(let error):
                            let errorString : String = error.localizedDescription
                            let drop = Drop(
                                title: errorString,
                                action: .init {
                                    Drops.hideCurrent()
                                }
                            )
                            Drops.show(drop)
                            isLoading = false
                        }
                    })
                } else {
                    Drops.show("Something went wrong. Try again")
                    isLoading = false
                }
            case .failure(let error):
                let errorString : String = error.localizedDescription
                let drop = Drop(
                    title: errorString,
                    action: .init {
                        Drops.hideCurrent()
                    }
                )
                Drops.show(drop)
                isLoading = false
            }
        })
    }
    
    private func showCardView(){
        isLoading = true
        paymentOptionsViewModel.getAccessToken(accountId: accountId, clientId: clientId, clientKey: clientKey, selectedPaymentOption: .CARD, completion: { result in
            switch result {
            case .success(let data):
                if (data){
                    paymentOptionsViewModel.createOrder(accountId: accountId, amount: "\(Octane.shared.getAmountFormated())", customerEmail: Octane.email, currency: "NGN", selectedPaymentOption: .CARD, completion: { result in
                        switch result {
                        case .success(let data):
                            if (data){
                                isLoading = false
                                accountName = paymentOptionsViewModel.accountName
                                accountNumber = paymentOptionsViewModel.accountNumber
                                bankName = paymentOptionsViewModel.bankName
                                isShowingCard = true
                            } else {
                                Drops.show("Something went wrong. Try again")
                                isLoading = false
                            }
                        case .failure(let error):
                            let errorString : String = error.localizedDescription
                            let drop = Drop(
                                title: errorString,
                                action: .init {
                                    Drops.hideCurrent()
                                }
                            )
                            Drops.show(drop)
                            isLoading = false
                        }
                    })
                } else {
                    Drops.show("Something went wrong. Try again")
                    isLoading = false
                }
            case .failure(let error):
                let errorString : String = error.localizedDescription
                let drop = Drop(
                    title: errorString,
                    action: .init {
                        Drops.hideCurrent()
                    }
                )
                Drops.show(drop)
                isLoading = false
            }
        })
    }
}

#Preview {
    PaymentsOptionsView(accountId: "", clientId: "", clientKey: "").onAppear{
        //Octane.shared.configure(clientId: "", accountId: "", clientKey: "")
    }
    
}
