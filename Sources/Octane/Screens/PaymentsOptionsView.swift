//
//  PaymentsOptionsView.swift
//
//
//  Created by Bezaleel Ashefor on 11/06/2024.
//

import SwiftUI

struct PaymentsOptionsView: View {
    @State var logo : Image?
    var roundPadding : CGFloat = 15
    @State var email : String
    @State var amount : String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
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
            Spacer().frame(height: 20)
            BorderButton(buttonText: "Cancel Payment", action: {
                presentationMode.wrappedValue.dismiss()
            })
            Spacer()
            FooterView()
        }
        .padding(roundPadding)
        .font(.custom(FontsManager.fontRegular, size: 14))
        .foregroundStyle(Color("Text Primary", bundle: .module))
    }
}

#Preview {
    PaymentsOptionsView(email: "knightbenax@gmail.com", amount: "10.00").onAppear{
        //Octane.shared.configure(clientId: "", accountId: "", clientKey: "")
    }
    
}
