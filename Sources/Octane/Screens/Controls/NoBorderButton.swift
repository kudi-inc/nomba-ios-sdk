//
//  NoBorderButton.swift
//  
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import SwiftUI

struct NoBorderButton: View {
    @State var buttonText : String
    @State var color : Color?
    var action : () -> () = {}
    
    var body: some View {
        Button(action: {
            action()
        }){
            HStack{
                Text(buttonText)
            }.padding(.vertical, 14).frame(maxWidth: .infinity)
            
            .foregroundStyle(color ?? Color("Text Primary", bundle: .module))
        }.font(.custom(FontsManager.fontRegular, size: 14))
    }
}

#Preview {
    NoBorderButton(buttonText: "Cancel Payment")
}
