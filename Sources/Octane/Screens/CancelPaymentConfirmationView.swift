//
//  CancelPaymentConfirmationView.swift
//
//
//  Created by Bezaleel Ashefor on 15/06/2024.
//

import SwiftUI

struct CancelPaymentConfirmationView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var parentPresentationMode : PresentationMode
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }){
                    Image("cancel", bundle: .module).padding()
                }
            }
            VStack(alignment: .center, spacing: 15){
                Image("warning", bundle: .module)
                Text("Are you sure?").font(.custom(FontsManager.fontBold, size: 24))
                Text("By closing this checkout, you are confirming to close this checkout and cancel the transaction.").lineSpacing(4)
                    .multilineTextAlignment(.center).foregroundStyle(Color("Neutral Eight", bundle: .module))
            }.padding(.horizontal)
            Spacer()
            HStack{
                YellowButton(buttonText: "Confirm", action: {
                    presentationMode.wrappedValue.dismiss()
                    parentPresentationMode.dismiss()
                })
                BorderButton(buttonText: "Cancel", action: {
                    presentationMode.wrappedValue.dismiss()
                })
            }.padding()
        }.foregroundStyle(Color("Text Primary", bundle: .module))
    }
}

#Preview {
    @Environment(\.presentationMode) var presentationMode
    return CancelPaymentConfirmationView(parentPresentationMode: .constant(presentationMode.wrappedValue))
}
