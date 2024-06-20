//
//  SwiftUIView.swift
//  
//
//  Created by Bezaleel Ashefor on 20/06/2024.
//

import SwiftUI

struct TransferExpiredView: View {
    var body: some View {
        VStack{
            VStack(spacing: 20){
                VStack(alignment: .center, spacing: 15){
                    Image("warning", bundle: .module)
                    Text("Account has expired").font(.custom(FontsManager.fontBold, size: 16))
                    Text("The account provided for this transaction has expired.")
                        .lineSpacing(2)
                        .multilineTextAlignment(.center)
                        .font(.custom(FontsManager.fontRegular, size: 14))
                }.padding(.vertical, 18).padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color("Neutral One", bundle: .module))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(Color("Neutral Eight", bundle: .module))
                VStack(alignment: .center, spacing: 15){
                    
                        
                }
                Spacer().frame(height: 6)
            }
        }
    }
}

#Preview {
    TransferExpiredView()
}
