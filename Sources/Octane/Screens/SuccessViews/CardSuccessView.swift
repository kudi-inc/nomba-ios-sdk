//
//  CardSuccessView.swift
//  
//
//  Created by Bezaleel Ashefor on 23/06/2024.
//

import SwiftUI

struct CardSuccessView: View {
    @State var logo : Image?
    var roundPadding : CGFloat = 15
    @Binding var parentPresentationMode : PresentationMode
    @State var isLoading = false
    @State private var progessAmount = 30.0
    @State private var progessTotal = 50.0
    @Binding var saveCard : Bool
    
    var body: some View {
        ZStack{
            VStack{
                TopView(logo: logo)
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
                    VStack(alignment: .center){
                        Text("Enter phone number to save your\n card for future use")
                            .fixedSize(horizontal: false, vertical: true)
                            .lineSpacing(2)
                            .multilineTextAlignment(.center)
                            
                    }.padding(.vertical, 20).padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(Color("F2F2F2", bundle: .module))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .foregroundStyle(Color("Neutral Eight", bundle: .module))
                }
                Spacer().frame(height: 10)
                BorderButton(buttonText: "Close checkout", action: {
                    parentPresentationMode.dismiss()
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
    @Environment(\.presentationMode) var presentationMode
    return CardSuccessView(parentPresentationMode: presentationMode, saveCard: .constant(true))
}
