//
//  TransferView.swift
//
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import SwiftUI

struct TransferView: View {
    @State var logo : Image?
    var roundPadding : CGFloat = 15
    @Environment(\.presentationMode) var presentationMode
    @State var isLoading = false
    
    var body: some View {
        ZStack{
            VStack{
                TopView(logo: logo)
                VStack(spacing: 0){
                    VStack{
                        Text("Transfer to account details below").lineSpacing(2).multilineTextAlignment(.center)
                    }
                    .padding(.vertical, 5)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(height: 50)
                BorderButton(buttonText: "Change payment method", action: {
                    presentationMode.wrappedValue.dismiss()
                })
                Spacer()
                FooterView()
            }
            .padding(roundPadding)
            .font(.custom(FontsManager.fontRegular, size: 14))
            .foregroundStyle(Color("Text Primary", bundle: .module))
            if (isLoading){
                LoaderView()
            }
        }
    }
}

#Preview {
    TransferView()
}
