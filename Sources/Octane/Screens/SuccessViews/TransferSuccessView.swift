//
//  SwiftUIView.swift
//  
//
//  Created by Bezaleel Ashefor on 19/06/2024.
//

import SwiftUI
import Drops

struct TransferSuccessView: View {
    @State var logo : Image?
    var roundPadding : CGFloat = 15
    @Binding var parentPresentationMode : PresentationMode
    @State var isLoading = false
    @State private var progessAmount = 30.0
    @State private var progessTotal = 50.0
    @State var showBackArrow = false
    @Binding var transactionResponse: CheckTransactionStatusResponse?
    
    var body: some View {
        ZStack{
            VStack{
                TopView(showBackArrow: $showBackArrow, logo: logo)
                VStack(spacing: 0){
                    Image("success", bundle: .module)
                    Text("Your Payment has been \nconfirmed successfully")
                        .lineSpacing(5)
                        .fixedSize()
                        .font(.custom(FontsManager.fontMedium, size: 22))
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10)
                    Spacer().frame(height: 15)
                    HStack{
                        Text("Your payment of \(Octane.shared.getAmountFormatedWithCurrency()) to \(Octane.customer) has been confirmed. You will now be redirected to your merchant’s site. Thank you")
                            .lineSpacing(2)
                            .multilineTextAlignment(.center)
                            
                    }.padding(.vertical, 24).padding(.horizontal, 20)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color("F2F2F2", bundle: .module))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .foregroundStyle(Color("Neutral Eight", bundle: .module))
                    
                }.frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(height: 10)
                BorderButton(buttonText: "Close checkout", action: {
                    parentPresentationMode.dismiss()
                    if transactionResponse != nil {
                        Octane.onTransactionComplete?(transactionResponse!)
                    }
                    
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
        }.background(Color.white.ignoresSafeArea())
    }
}

#Preview {
    @Environment(\.presentationMode) var presentationMode
    return TransferSuccessView(parentPresentationMode: presentationMode,transactionResponse: .constant(nil))
}
