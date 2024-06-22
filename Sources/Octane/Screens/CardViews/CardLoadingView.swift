//
//  SwiftUIView.swift
//  
//
//  Created by Bezaleel Ashefor on 22/06/2024.
//

import SwiftUI

struct CardLoadingView: View {
    var body: some View {
        VStack{
            VStack{
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color("Button Primary", bundle: .module)))
                      .scaleEffect(2.0, anchor: .center)
                Text("Please wait").font(.custom(FontsManager.fontRegular, size: 14)).offset(y: 24)
            }.offset(y: -80)
        }.foregroundStyle(Color("Text Primary", bundle: .module))
    }
}

#Preview {
    CardLoadingView()
}
