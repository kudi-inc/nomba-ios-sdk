//
//  SwiftUIView.swift
//  
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import SwiftUI

struct TopView: View {
    @Binding var showBackArrow : Bool
    @State var logo : Image?
    
    var body: some View {
        VStack{
            HStack(alignment: .center){
                if let logo = logo {
                    logo.resizable().frame(width: 42, height: 42)
                } else {
                    RoundedRectangle(cornerRadius: 4).frame(width: 42, height: 42)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 4){
                    Text("Pay ") +
                    Text("\(Octane.shared.getAmountFormatedWithCurrency())").font(.custom(FontsManager.fontBold, size: 14))
                    Text(Octane.email).opacity(0.6).font(.custom(FontsManager.fontRegular, size: 12))
                }
            }
            Spacer().frame(height: 15)
            Divider()
            Spacer().frame(height: 20)
        }
    }
}

#Preview {
    TopView(showBackArrow: .constant(false))
}
