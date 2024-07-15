//
//  BackView.swift
//
//
//  Created by Bezaleel Ashefor on 15/07/2024.
//

import SwiftUI

struct BackView: View {
    
        var body: some View {
            VStack{
                HStack(alignment: .center){
                    Image(systemName: "arrow.backward")
                    Spacer()
                }
                Spacer().frame(height: 15)
                Divider()
                Spacer().frame(height: 20)
            }
        }
}

#Preview {
    BackView()
}
