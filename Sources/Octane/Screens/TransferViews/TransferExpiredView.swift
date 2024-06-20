//
//  SwiftUIView.swift
//  
//
//  Created by Bezaleel Ashefor on 20/06/2024.
//

import SwiftUI

struct TransferExpiredView: View {
    
    var tryAgainAction : () -> () = {}
    var sentMoneyAction : () -> () = {}
    
    var body: some View {
        VStack{
            VStack(spacing: 20){
                VStack(alignment: .center, spacing: 25){
                    Image("warning_dark", bundle: .module)
                    VStack(spacing: 10){
                        Text("Account has expired").font(.custom(FontsManager.fontBold, size: 16))
                        Text("The account provided for this\n transaction has expired.")
                            .lineSpacing(2)
                            .multilineTextAlignment(.center)
                    }
                }.padding(.vertical, 38).padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color("Neutral One", bundle: .module))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(Color("Neutral Eight", bundle: .module))
                
                HStack(alignment: .center, spacing: 15){
                    YellowButton(buttonText: "Try again", action: {
                        tryAgainAction()
                    })
                    BorderButton(buttonText: "I've sent the money", action: {
                        sentMoneyAction()
                    })
                }
                NoBorderButton(buttonText: "Try another payment method", action: {
                }).offset(y: -10)
                
            }
        }
    }
}

#Preview {
    TransferExpiredView()
}
