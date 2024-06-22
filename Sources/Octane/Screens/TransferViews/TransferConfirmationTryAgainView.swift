//
//  SwiftUIView.swift
//  
//
//  Created by Bezaleel Ashefor on 22/06/2024.
//

import SwiftUI

struct TransferConfirmationTryAgainView: View {
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var progessAmount = 0.0
    @State private var progessTotal : Double = 600
    @State private var timeRemaining = 600
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Text("Taking longer than expected? You don't need to\n stay here till we confirm it")
                    .lineSpacing(2)
                    .multilineTextAlignment(.leading)
                    .font(.custom(FontsManager.fontRegular, size: 14))
                    Spacer()
                ProgressView().tint(Color("Neutral Four", bundle: .module)).scaleEffect(CGSize(width: 1.5, height: 1.5))
            }.padding(.vertical, 18).padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color("FFFAE6", bundle: .module))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .foregroundStyle(Color("Neutral Eight", bundle: .module))
            Spacer().frame(height: 6)
            HStack(alignment: .center, spacing: 15){
                YellowButton(buttonText: "Try again", icon: Image("refresh", bundle: .module), action: {
                    // tryAgainAction()
                })
                BorderButton(buttonText: "Get help", icon: Image("refresh", bundle: .module),
                             action: {
                    // sentMoneyAction()
                })
            }
        }
    }
}

#Preview {
    TransferConfirmationTryAgainView()
}
