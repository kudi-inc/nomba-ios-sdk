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
    @State var email : String
    @State var amount : String
    @State var isLoading = false
    @Environment(\.presentationMode) var presentationMode
    var paymentOptionsViewModel = PaymentOptionsViewModel()
    
    var body: some View {
        ZStack{
            VStack{
                HStack(alignment: .center){
                    if let logo = logo {
                        logo.resizable().frame(width: 42, height: 42)
                    } else {
                        RoundedRectangle(cornerRadius: 4).frame(width: 42, height: 42)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 4){
                        Text("Pay ") + Text("\(amount)").font(.custom(FontsManager.fontBold, size: 12))
                        Text(email).opacity(0.6)
                    }.font(.custom(FontsManager.fontRegular, size: 12))
                }
                Spacer().frame(height: 15)
                Divider()
                Spacer().frame(height: 20)
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
        }
    }
    
    private func showTransferView(){
        isLoading = true
        paymentOptionsViewModel.showTransferView(accountId: accountId, clientId: clientId, clientKey: clientKey, selectedPaymentOption: .TRANSFER, completion: { result in
            switch result {
            case .success(let data):
                if (data){
//                    paymentOptionsViewModel.createOrder(callbackURL: <#T##String#>, accountId: <#T##String#>, amount: <#T##String#>, customerEmail: <#T##String#>, currency: <#T##String#>, selectedPaymentOption: <#T##PaymentOption#>, completion: <#T##(Result<Bool, any Error>) -> Void#>)
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
    }
}

#Preview {
    PaymentsOptionsView(accountId: "", clientId: "", clientKey: "", email: "knightbenax@gmail.com", amount: "10.00").onAppear{
        //Octane.shared.configure(clientId: "", accountId: "", clientKey: "")
    }
    
}
