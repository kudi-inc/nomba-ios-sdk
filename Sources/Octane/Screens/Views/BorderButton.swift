//
//  BorderButton.swift
//
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import SwiftUI

struct BorderButton: View {
    @State var buttonText : String
    var action : () -> () = {}
    
    var body: some View {
        Button(action: {
            action()
        }){
            HStack{
                Text(buttonText)
            }.padding(.vertical, 14).frame(maxWidth: .infinity).overlay{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("Neutral Two", bundle: .module), lineWidth: 1)
            }
            .foregroundStyle(Color("Text Primary", bundle: .module))
        }.font(.custom(FontsManager.fontRegular, size: 14))
    }
}

#Preview {
    BorderButton(buttonText: "Cancel Payment")
}
