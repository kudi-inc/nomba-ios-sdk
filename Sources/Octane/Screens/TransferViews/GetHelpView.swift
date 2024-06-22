//
//  SwiftUIView.swift
//  
//
//  Created by Bezaleel Ashefor on 21/06/2024.
//

import SwiftUI

struct GetHelpView: View {
    var tryAgainAction : () -> () = {}
    var sentMoneyAction : () -> () = {}
    
    var body: some View {
        VStack{
            VStack(spacing: 40){
                VStack(alignment: .center, spacing: 25){
                    Image("get_help", bundle: .module)
                    VStack(spacing: 10){
                        Text("Note that this transaction will be\n completed automatically as soon as we\n confirm your payment.")
                            .lineSpacing(2)
                            .multilineTextAlignment(.center)
                    }
                }.padding(.vertical, 30).padding(.horizontal, 20)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color("Neutral One", bundle: .module))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .foregroundStyle(Color("Neutral Eight", bundle: .module))
                VStack{
                    Text("Need further help? Reach out to us on.")
                    Text("support@nomba.com")
                }.foregroundStyle(Color("Neutral Eight", bundle: .module))
                HStack(alignment: .center, spacing: 15){
                    YellowButton(buttonText: "Keep waiting", action: {
                        tryAgainAction()
                    })
                    BorderButton(buttonText: "Close checkout", action: {
                        sentMoneyAction()
                    })
                }
                
            }
        }
    }
}

#Preview {
    GetHelpView()
}
