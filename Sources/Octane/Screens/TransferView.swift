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
    @Binding var paymentOptionsViewModel : PaymentOptionsViewModel
    
    var body: some View {
        ZStack{
            VStack{
                TopView(logo: logo)
                switch transferPaymentStatus {
                case .DETAILS:
                    TransferDetailsView(accountNumber: $accountNumber, bankName: $bankName, accountName: $accountName, onTimerFinished: onDetailsTimerFinished)
                case .ACCOUNT_EXPIRED:
                    TransferExpiredView(tryAgainAction: onFetchTransferAgain, sentMoneyAction: {})
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
        //show expired account
        transferPaymentStatus = .ACCOUNT_EXPIRED
    }
    
    func onFetchTransferAgain(){
        isLoading = true
        paymentOptionsViewModel.fetchBankForTransfer(completion: { result in
            switch result {
            case .success(let data):
                if (data) {
                    accountName = paymentOptionsViewModel.accountName
                    accountNumber = paymentOptionsViewModel.accountNumber
                    bankName = paymentOptionsViewModel.bankName
                    transferPaymentStatus = .DETAILS
                    isLoading = false
                } else {
                    if (Octane.errorString.isEmpty) {
                        Drops.show("Something went wrong. Try again")
                    } else {
                        let errorString = Octane.errorString
                        Drops.show(Util.getDrop(message: errorString))
                    }
                }
            case .failure(let error):
                isLoading = false
                if (Octane.errorString.isEmpty) {
                    let errorString = "Something went wrong. Try again" + error.localizedDescription
                    Drops.show(Util.getDrop(message: errorString))
                } else {
                    let errorString = Octane.errorString
                    Drops.show(Util.getDrop(message: errorString))
                }
            }
        })
        
    }
    
    func onTransferSent(){
        transferPaymentStatus = .CONFIRMATION_WAITING
    }
    
    
    
   
}

#Preview {
    TransferView(accountNumber: "98762371891", bankName: "Amucha MFB", accountName: "Abdullahi Abodunrin", paymentOptionsViewModel: .constant(PaymentOptionsViewModel()))
}
