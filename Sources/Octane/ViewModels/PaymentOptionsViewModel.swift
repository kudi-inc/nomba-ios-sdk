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
    
    func showTransferView(accountId: String, clientId: String, clientKey: String, selectedPaymentOption: PaymentOption, completion: @escaping (Result<Bool, Error>) -> Void){
        networkManager.getAccessToken(accountId: accountId, clientId: clientId, clientKey: clientId, selectedPaymentOption: selectedPaymentOption, completion: { result in
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
                        
                    } else if(selectedPaymentOption == .CARD){
                        completion(.success(true))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    
    func fetchBankForTransfer(completion: @escaping (Result<FlashAccountResponse, Error>) -> Void){
        
    }
    
    
}
