//
//  TransferView.swift
//
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import SwiftUI
import Drops

struct TransferView: View {
    @State var logo : Image?
    var roundPadding : CGFloat = 15
    
    @State var isLoading = false
    @State var accountNumber : String
    @State var bankName : String
    @State var accountName : String
    @State var transferPaymentStatus : TransferPaymentStatus = .DETAILS
   
    
    var body: some View {
        ZStack{
            VStack{
                TopView(logo: logo)
                switch transferPaymentStatus {
                case .DETAILS:
                    TransferDetailsView(accountNumber: $accountNumber, bankName: $bankName, accountName: $accountName, onTimerFinished: onDetailsTimerFinished)
                case .CONFIRMATION_WAITING:
                    TransferConfirmationView()
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
    
    func onDetailsTimerFinished() {
        transferPaymentStatus = .CONFIRMATION_WAITING
    }
    
   
}

#Preview {
    TransferView(accountNumber: "98762371891", bankName: "Amucha MFB", accountName: "Abdullahi Abodunrin")
}
