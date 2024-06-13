//
//  TransferView.swift
//
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import SwiftUI

struct TransferView: View {
    @State var logo : Image?
    var roundPadding : CGFloat = 15
    @Environment(\.presentationMode) var presentationMode
    @State var isLoading = false
    @State var accountNumber : String = "98762371891"
    @State var bankName : String = "Amucha MFB"
    @State var accountName : String = "Abdullahi Abodunrin"
    
    var body: some View {
        ZStack{
            VStack{
                TopView(logo: logo)
                VStack(spacing: 0){
                    Text("Transfer to account details below")
                        .lineSpacing(2)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10)
                    Spacer().frame(height: 15)
                    HStack{
                        VStack(alignment: .leading, spacing: 4){
                            Text("Account Number").font(.custom(FontsManager.fontRegular, size: 12))
                                .foregroundStyle(Color("Neutral Eight", bundle: .module))
                            Text(accountNumber)
                        }
                        Spacer()
                        Button(action: {}){
                            Text("COPY").font(.custom(FontsManager.fontRegular, size: 10))
                                .padding(.vertical, 7)
                                .padding(.horizontal, 10)
                                .background(Color("Neutral One", bundle: .module))
                                .clipShape(RoundedRectangle(cornerRadius: 4))
                                .contentShape(Rectangle())
                        }
                    }.padding(.vertical, 12).padding(.horizontal, 16)
                        .overlay{
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("Blue Two", bundle: .module), lineWidth: 1)
                        }.onTapGesture {
                            
                        }
                    Spacer().frame(height: 16)
                    HStack{
                        VStack(alignment: .leading, spacing: 4){
                            Text("Bank Name")
                                .font(.custom(FontsManager.fontRegular, size: 12))
                                .foregroundStyle(Color("Neutral Eight", bundle: .module))
                            Text(bankName)
                        }
                        Spacer()
                        VStack(alignment: .leading, spacing: 4){
                            Text("Account Name")
                                .font(.custom(FontsManager.fontRegular, size: 12))
                                .foregroundStyle(Color("Neutral Eight", bundle: .module))
                            Text(accountName)
                        }
                    }.padding(.vertical, 12).padding(.horizontal, 16)
                        .background(Color("Blue One", bundle: .module))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    Spacer().frame(height: 16)
                    HStack{
                        VStack(alignment: .leading, spacing: 4){
                            Text("Amount").font(.custom(FontsManager.fontRegular, size: 12))
                                .foregroundStyle(Color("Neutral Eight", bundle: .module))
                            Text("\(Octane.shared.getAmountFormatedWithCurrency())")
                        }
                        Spacer()
                    }.padding(.vertical, 12).padding(.horizontal, 16)
                        .background(Color("Blue One", bundle: .module))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(height: 50)
                YellowButton(buttonText: "I have sent the money", action: {
                    
                })
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
    TransferView()
}
