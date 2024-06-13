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
    @State var isLoading = false
    @State var creditCardNumber : String = ""
    @State var bankName : String = "Amucha MFB"
    @State var accountName : String = "Abdullahi Abodunrin"
    @State private var saveCard = false
    
    var body: some View {
        ZStack{
            VStack{
                TopView(logo: logo)
                VStack(spacing: 0){
                    Text("Enter your card information for payment")
                        .lineSpacing(2)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10)
                    Spacer().frame(height: 15)
                    HStack{
                        VStack(alignment: .leading, spacing: 4){
                            Text("Card number").font(.custom(FontsManager.fontRegular, size: 12))
                                .foregroundStyle(Color("Neutral Eight", bundle: .module))
                            TextField("", text: $creditCardNumber, prompt: Text("0000 0000 0000 0000").foregroundColor(Color("Neutral Four", bundle: .module)))
                        }
                        Spacer()
                        Image("Payment Icon", bundle: .module)
                    }.padding(.vertical, 12).padding(.horizontal, 16)
                        .background(Color("Neutral One", bundle: .module))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay{
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("Neutral Two", bundle: .module), lineWidth: 1)
                        }
                    Spacer().frame(height: 16)
                    HStack(spacing: 15){
                        HStack{
                            VStack(alignment: .leading, spacing: 4){
                                Text("Expiry date")
                                    .font(.custom(FontsManager.fontRegular, size: 12))
                                    .foregroundStyle(Color("Neutral Eight", bundle: .module))
                                TextField("", text: $creditCardNumber, prompt: Text("MM/YY").foregroundColor(Color("Neutral Four", bundle: .module)))
                            }
                            Spacer()
                        }.padding(.vertical, 12).padding(.horizontal, 16)
                            .background(Color("Neutral One", bundle: .module))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay{
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("Neutral Two", bundle: .module), lineWidth: 1)
                            }
                        
                        HStack{
                            VStack(alignment: .leading, spacing: 4){
                                Text("CVV").font(.custom(FontsManager.fontRegular, size: 12))
                                    .foregroundStyle(Color("Neutral Eight", bundle: .module))
                                TextField("", text: $creditCardNumber, prompt: Text("None").foregroundColor(Color("Neutral Four", bundle: .module)))
                            }
                            Spacer()
                        }.padding(.vertical, 12).padding(.horizontal, 16)
                            .background(Color("Neutral One", bundle: .module))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay{
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("Neutral Two", bundle: .module), lineWidth: 1)
                            }
                    }
                    Spacer().frame(height: 18)
                    Toggle(isOn: $saveCard) {
                        Text("Save card for future use")
                    }.padding(.horizontal, 5)
                }.frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(height: 30)
                YellowButton(buttonText: "Pay \(Octane.shared.getAmountFormatedWithCurrency())", action: {
                }).opacity(0.3)
                Spacer().frame(height: 24)
                Divider()
                Spacer().frame(height: 24)
                BorderButton(buttonText: "Change payment method", action: {
                    presentationMode.wrappedValue.dismiss()
                })
                NoBorderButton(buttonText: "Cancel payment", action: {
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
}

#Preview {
    CardView()
}
