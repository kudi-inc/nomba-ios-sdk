//
//  SwiftUIView.swift
//  
//
//  Created by Bezaleel Ashefor on 23/06/2024.
//

import SwiftUI

struct CardSuccessMainView: View {
    @Binding var saveCard : Bool
    @Binding var otpPhoneNumber : String
    @Binding var parentPresentationMode : PresentationMode
    
    var sendOTPAction : () -> () = {}
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing: 0){
                Image("success", bundle: .module)
                Text("Your Payment has been \nconfirmed successfully")
                    .lineSpacing(5)
                    .fixedSize()
                    .font(.custom(FontsManager.fontMedium, size: 22))
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 10)
                Spacer().frame(height: 15)
                HStack{
                    Text("Your payment of \(Octane.shared.getAmountFormatedWithCurrency()) to \(Octane.customer) has been confirmed. You will now be redirected to your merchant’s site. Thank you")
                        .lineSpacing(2)
                        .multilineTextAlignment(.center)
                        
                }.padding(.vertical, 24).padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color("F2F2F2", bundle: .module))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(Color("Neutral Eight", bundle: .module))
                
            }.frame(maxWidth: .infinity, alignment: .leading)
            if (saveCard){
                VStack(spacing: 0){
                    Spacer().frame(height: 15)
                    VStack(alignment: .center){
                        Text("Enter phone number to save your\n card for future use")
                            .fixedSize(horizontal: false, vertical: true)
                            .lineSpacing(2)
                            .multilineTextAlignment(.center)
                        Spacer().frame(height: 15)
                        HStack{
                            TextField("", text: $otpPhoneNumber, prompt: Text("08012345678")).keyboardType(.numberPad)
                        }.padding().background(Color.white)
                    }.padding(.vertical, 20).padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color("F2F2F2", bundle: .module))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .foregroundStyle(Color("Neutral Eight", bundle: .module))
                    YellowButton(buttonText: "Verify", action: {
                        if (!otpPhoneNumber.isEmpty){
                            sendOTPAction()
                        }
                    })
                    Spacer().frame(height: 15)
                }
            }
            Spacer().frame(height: 10)
            BorderButton(buttonText: "Close checkout", action: {
                parentPresentationMode.dismiss()
            })
            Spacer().frame(height: 60)
        }
    }
}

#Preview {
    @Environment(\.presentationMode) var presentationMode
    return CardSuccessMainView(saveCard: .constant(true), otpPhoneNumber: .constant(""), parentPresentationMode: presentationMode)
}
