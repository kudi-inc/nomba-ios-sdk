//
//  BorderButton.swift
//
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import SwiftUI

struct BorderButton: View {
    @State var buttonText : String
    @State var icon : Image?
    var action : () -> () = {}
    
    var body: some View {
        Button(action: {
            action()
        }){
            HStack{
                if ((icon) != nil){
                    icon
                }
                Text(buttonText)
            }.padding(.vertical, 14).frame(maxWidth: .infinity).overlay{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("Neutral Two", bundle: .module), lineWidth: 1)
            }
            .foregroundStyle(Color("Text Primary", bundle: .module))
        }.font(.custom(FontsManager.fontRegular, size: 16))
    }
}

#Preview {
    BorderButton(buttonText: "Cancel Payment")
}
