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
            }.overlay{
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color("Neutral Two", bundle: .module), lineWidth: 2)
            }
            .foregroundStyle(Color("Text Primary", bundle: .module))
        }
    }
}

#Preview {
    BorderButton(buttonText: "Cancel Payment")
}
