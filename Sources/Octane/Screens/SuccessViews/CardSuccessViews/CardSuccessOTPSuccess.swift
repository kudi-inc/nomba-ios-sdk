//
//  SwiftUIView.swift
//  
//
//  Created by Bezaleel Ashefor on 23/06/2024.
//

import SwiftUI

struct CardSuccessOTPSuccess: View {
    @Binding var parentPresentationMode : PresentationMode
    
    var body: some View {
        VStack{
            Image("success", bundle: .module)
            Text("Phone number confirmed")
                .lineSpacing(5)
                .font(.custom(FontsManager.fontMedium, size: 22))
                .multilineTextAlignment(.center)
                .padding(.vertical, 10)
            
            Spacer().frame(height: 15)
            HStack{
                Text("Your card has been securely saved and it will be available for your next checkout with \(Octane.customer). You will now be redirected to your merchant’s app. Thank you")
                    .lineSpacing(2)
                    .multilineTextAlignment(.center)
                    
            }.padding(.vertical, 24).padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color("F2F2F2", bundle: .module))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .foregroundStyle(Color("Neutral Eight", bundle: .module))
            
            Spacer().frame(height: 40)
            BorderButton(buttonText: "Close checkout", action: {
                parentPresentationMode.dismiss()
            })
        }
    }
}

#Preview {
    @Environment(\.presentationMode) var presentationMode
    return CardSuccessOTPSuccess(parentPresentationMode: presentationMode)
}
