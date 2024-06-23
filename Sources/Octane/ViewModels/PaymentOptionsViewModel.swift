//
//  PaymentOptionsViewModel.swift
//
//
//  Created by Bezaleel Ashefor on 11/06/2024.
//

import Foundation

class PaymentOptionsViewModel : ObservableObject {
    
    var callbackURL : String = "https://octane/ios.sdk/callback"
    var customerId = UUID().uuidString
    var networkManager = NetworkManager.shared
    var orderReference : String = UUID().uuidString
    
    var accountNumber : String = "98762371891"
    var bankName : String = "Amucha MFB"
    var accountName : String = "Abdullahi Abodunrin"
    
    
    func getAccessToken(accountId: String, clientId: String, clientKey: String, selectedPaymentOption: PaymentOption, completion: @escaping (Result<Bool, Error>) -> Void){
        networkManager.getAccessToken(accountId: accountId, clientId: clientId, clientKey: clientKey, selectedPaymentOption: selectedPaymentOption, completion: { result in
            completion(result)
        })
    }
    
    func createOrder(accountId: String, amount: String, customerEmail: String, currency : String, selectedPaymentOption: PaymentOption, completion: @escaping (Result<Bool, Error>) -> Void){
        networkManager.createOrder(orderReference: orderReference, customerId: customerId, customerEmail: customerEmail, callbackURL: callbackURL, amount: amount, currency: currency, accountId: accountId, selectedPaymentOption: selectedPaymentOption, completion: { [self] result in
            switch result {
            case .success(let response):
                orderReference = response.data.orderReference
                if (response.code == "00" || response.code == "400") {
                    // successfully created a new Order or the order already exists, move on
                    if (selectedPaymentOption == .TRANSFER){
                        //fetch banks
                        fetchBankForTransfer(completion: { result in
                            completion(.success(true))
                        })
                    } else if(selectedPaymentOption == .CARD){
                        completion(.success(true))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func submitCardDetails(cardNumber: String, cardExpMonth: String, cardExpYear : String, cvv: String, cardPin: String, saveCard : Bool, completion: @escaping (Result<SubmitCardDetailsResponse, Error>) -> Void){
        networkManager.submitCardDetails(cardNumber: cardNumber, cardExpMonth: cardExpMonth, cardExpYear: cardExpYear, cvv: cvv, cardPin: cardPin, orderReference: orderReference, saveCard: saveCard, completion: { result in
            completion(result)
        })
    }
    
    func submitOTP(otpText : String, transactionID : String, completion: @escaping (Result<SubmitOTPResponse, Error>) -> Void){
        networkManager.submitOTPDetails(orderReference: orderReference, otpText: otpText, transactionID: transactionID, completion:{ result in
            completion(result)
        })
    }
    
    func checkTransactionOrderStatus(completion: @escaping (Result<CheckTransactionStatusResponse, Error>) -> Void){
        networkManager.checkTransactionOrderStatus(orderReference: orderReference, completion: { result in
            completion(result)
        })
    }
    
    func requestOTPForCardSaving(phoneNumber: String, completion: @escaping (Result<RequestCardOTPResponse, Error>) -> Void){
        networkManager.requestOTPForCardSaving(orderReference: orderReference, phoneNumber: phoneNumber, completion: { result in
            completion(result)
        })
    }
    
    func submitOTPForCardSaving(phoneNumber: String, otp: String, completion: @escaping (Result<RequestCardOTPResponse, Error>) -> Void){
        networkManager.submitOTPForCardSaving(orderReference: orderReference, phoneNumber: phoneNumber, otp: otp, completion: { result in
            completion(result)
        })
    }
    
    func fetchBankForTransfer(completion: @escaping (Result<Bool, Error>) -> Void){
        networkManager.getFlashAccount(orderReference: orderReference, completion: { [self] result in
            switch result {
            case .success(let data):
                accountName = data.data.accountName
                bankName = data.data.bankName
                accountNumber = data.data.accountNumber
                completion(.success(true))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    
}
