//
//  SwiftUIView.swift
//  
//
//  Created by Bezaleel Ashefor on 21/06/2024.
//

import SwiftUI

struct TransferConfirmationFailedView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var progessAmount = 0.0
    @State private var progessTotal : Double = 600
    @State private var timeRemaining = 600
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Text("This transaction has taken longer than usual? \n Kindly try again or get help, to continue. Thank you")
                    .lineSpacing(2)
                    .multilineTextAlignment(.leading)
                    .font(.custom(FontsManager.fontRegular, size: 14))
                    
            }.padding(.vertical, 18).padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color("Red One", bundle: .module))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .foregroundStyle(Color("Neutral Eight", bundle: .module))
            
            HStack(alignment: .center, spacing: 5){
                Text("Time elapsed")
                    .font(.custom(FontsManager.fontRegular, size: 12))
                    .foregroundStyle(Color("8C8C8C", bundle: .module))
                Image("clock", bundle: .module)
                ProgressView(value: progessAmount, total: progessTotal).frame(width: 80).tint(Color("Button Primary", bundle: .module))
            }.padding(.vertical, 14).frame(maxWidth: .infinity).overlay{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("Neutral Two", bundle: .module), lineWidth: 1)
            }
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
    TransferConfirmationFailedView()
}
