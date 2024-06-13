//
//  YellowButton.swift
//
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import SwiftUI

struct YellowButton: View {
    @State var buttonText : String
    var action : () -> () = {}
    
    var body: some View {
        Button(action: {
            action()
        }){
            HStack{
                Text(buttonText)
            }.padding(.vertical, 14).frame(maxWidth: .infinity)
                .background(Color("Button Primary", bundle: .module))
                .clipShape(RoundedRectangle(cornerRadius: 8))
            .foregroundStyle(Color("Text Primary", bundle: .module))
        }.font(.custom(FontsManager.fontRegular, size: 14))
    }
}

#Preview {
    YellowButton(buttonText: "I have sent the money")
}
