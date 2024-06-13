//
//  PaymentsOptionsView.swift
//
//
//  Created by Bezaleel Ashefor on 11/06/2024.
//

import SwiftUI

struct PaymentsOptionsView: View {
    @State var logo : Image?
    var roundPadding : CGFloat = 10
    @State var email : String
    @State var amount : String
    
    var body: some View {
        VStack{
            HStack{
                logo
                Spacer()
                VStack(alignment: .trailing){
                    Text("Pay \(amount)")
                    Text(email)
                }.font(.custom(FontsManager.fontRegular, size: 12))
            }
            Divider()
            VStack{
                Text("Choose any of the payment methods\nbelow to pay")
            }.padding(.vertical).padding(.horizontal, 18).frame(maxWidth: .infinity, alignment: .leading).background(Color("Neutral One", bundle: Bundle.module))
                .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .padding(roundPadding)
        .font(.custom(FontsManager.fontRegular, size: 14))
    }
}

#Preview {
    PaymentsOptionsView(email: "knightbenax@gmail.com", amount: "10.00").onAppear{
        //Octane.shared.configure(clientId: "", accountId: "", clientKey: "")
    }
    
}
