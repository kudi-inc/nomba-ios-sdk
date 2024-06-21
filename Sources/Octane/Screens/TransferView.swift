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
                    TransferDetailsView(accountNumber: $accountNumber, bankName: $bankName, accountName: $accountName, onTimerFinished: onDetailsTimerFinished, sentMoneyAction: onTransferSent)
                case .ACCOUNT_EXPIRED:
                    TransferDetailsExpiredView(tryAgainAction: onFetchTransferAgain, sentMoneyAction: onTransferSent)
                case .CONFIRMATION_WAITING:
                    TransferConfirmationView(onTimerEndedAction: onTransferConfirmationFailed, onHelpAction: onHelpAction)
                case .CONFIRMATION_WAITING_FAILED:
                    TransferConfirmationFailedView()
                case .GET_HELP:
                    GetHelpView()
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
    
    func onTransferConfirmationFailed(){
        transferPaymentStatus = .CONFIRMATION_WAITING_FAILED
    }
    
    
    func onHelpAction() {
        transferPaymentStatus = .GET_HELP
    }
    
    
    
   
}

#Preview {
    TransferView(accountNumber: "98762371891", bankName: "Amucha MFB", accountName: "Abdullahi Abodunrin", paymentOptionsViewModel: .constant(PaymentOptionsViewModel()))
}
