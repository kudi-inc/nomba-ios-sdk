//
//  CardView.swift
//
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import SwiftUI

struct CardView: View {
    @State var logo : Image?
    var roundPadding : CGFloat = 15
    @Environment(\.presentationMode) var presentationMode
    @State var isLoading = false
    @State var cardPaymentStatus : CardPaymentStatus = .DETAILS
   
    
    var body: some View {
        ZStack{
            VStack{
                TopView(logo: logo)
                switch (cardPaymentStatus) {
                case .DETAILS:
                    CardDetailsView()
                }
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
    CardView()
}
