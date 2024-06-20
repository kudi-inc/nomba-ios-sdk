//
//  LoaderView.swift
//
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
        ZStack{
            ProgressView().controlSize(.large).progressViewStyle(.circular).tint(.white)
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black.opacity(0.6).ignoresSafeArea())
    }
}

#Preview {
    LoaderView()
}
