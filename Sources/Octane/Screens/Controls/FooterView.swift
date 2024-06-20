//
//  FooterView.swift
//
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        HStack(spacing: 6){
            Text("Secured by")
            Image("Logo", bundle: Bundle.module).offset(y: 1)
        }.font(.custom(FontsManager.fontRegular, size: 14))
    }
}

#Preview {
    FooterView()
}
