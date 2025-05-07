//
//  NetworkManager.swift
//
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import Foundation


class NetworkManager{
    
    public static let shared = NetworkManager()
    var accessToken : String?
    var refreshToken : String?
    
    private init() {}
    
    
    func createOrder(orderReference: String, customerId: String, customerEmail: String, callbackURL : String, amount: String, currency : String,source : String, accountId: String, clientId: String, selectedPaymentOption: PaymentOption, completion: @escaping (Result<CreateOrderResponse, Error>) -> Void){
        let url = URL(string:  "\(Constants.base_url)/checkout/order")!
    
        let order : [String: Any] = ["tokenizeCard": "true", "order": ["orderReference": "\(orderReference)", "customerId": "\(customerId)", "callbackUrl": "\(callbackURL)", "customerEmail": "\(customerEmail)", "amount": "\(amount)", "currency": "\(currency)"]]
        
        pingPonger(url: url, httpMethod: .POST, headers: ["accountId": accountId, "public_key": clientId, "X-Nomba-Integration":source], bodyValues: order, completion: { result in
            switch result {
            case .success(let data):
                do {
                    // Parse the JSON data
                    let createOrderResponse = try JSONDecoder().decode(CreateOrderResponse.self, from: data)
                    completion(.success(createOrderResponse))
                } catch ((let error)) {
                    print(String(describing: error))
                    completion(.failure(error))
                }
            case .failure(let error):
                print(String(describing: error))
                completion(.failure(error))
            }
        })
    }
    
    
    func submitCardDetails(cardNumber: String, cardExpMonth: String, cardExpYear : String, cvv: String, cardPin: String, orderReference: String, saveCard : Bool, completion: @escaping (Result<SubmitCardDetailsResponse, Error>) -> Void){
        let url = URL(string:  "\(Constants.base_url)/checkout/checkout-card-detail")!
    
        let parameters : [String: Any] = ["cardDetails": "{\"cardCVV\": \(cvv), \"cardExpiryMonth\": \(cardExpMonth), \"cardExpiryYear\": \(cardExpYear), \"cardNumber\": \"\(cardNumber)\",\"cardPin\": \(cardPin)}",
                                           "key": "",
                                          "orderReference": "\(orderReference)",
                                          "saveCard": "\(String(describing: saveCard))",
                                          "deviceInformation": ["httpBrowserLanguage": "en-GB",
                                                                "httpBrowserJavaEnabled": "true",
                                                                "httpBrowserJavaScriptEnabled": "true",
                                                                "httpBrowserColorDepth": "30",
                                                                "httpBrowserScreenHeight": "900",
                                                                "httpBrowserScreenWidth": "1500",
                                                                "httpBrowserTimeDifference": "-60",
                                                                "userAgentBrowserValue": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)",
                                                                "deviceChannel": "Browser"
                                                               ]
        ]
        
        pingPonger(url: url, httpMethod: .POST, headers:  [:], bodyValues: parameters, completion: { result in
            switch result {
            case .success(let data):
                do {
                    // Parse the JSON data
                    let jsonResponse = try JSONDecoder().decode(SubmitCardDetailsResponse.self, from: data)
                    completion(.success(jsonResponse))
                } catch ((let error)) {
                    print(String(describing: error))
                    completion(.failure(error))
                }
            case .failure(let error):
                print(String(describing: error))
                completion(.failure(error))
            }
        })
    }
    
    
    func submitOTPDetails(orderReference: String, otpText : String, transactionID : String, completion: @escaping (Result<SubmitOTPResponse, Error>) -> Void){
        let url = URL(string:  "\(Constants.base_url)/checkout/checkout-card-otp")!
    
        let parameters : [String: Any] = ["otp": "\(otpText)",
                                          "orderReference": "\(orderReference)",
                                          "transactionId": "\(transactionID)"
        ]
        
        pingPonger(url: url, httpMethod: .POST, headers:  [:], bodyValues: parameters, completion: { result in
            switch result {
            case .success(let data):
                do {
                    // Parse the JSON data
                    let jsonResponse = try JSONDecoder().decode(SubmitOTPResponse.self, from: data)
                    completion(.success(jsonResponse))
                } catch ((let error)) {
                    print(String(describing: error))
                    completion(.failure(error))
                }
            case .failure(let error):
                print(String(describing: error))
                completion(.failure(error))
            }
        })
    }
    
    
    func checkTransactionOrderStatus(orderReference: String, completion: @escaping (Result<CheckTransactionStatusResponse, Error>) -> Void){
        let url = URL(string:  "\(Constants.base_url)/checkout/confirm-transaction-receipt/")!
        let paramaters : [String: Any] = ["orderReference": orderReference]
        pingPonger(url: url, httpMethod: .POST, headers: [:], bodyValues: paramaters, completion: { result in
            switch result {
            case .success(let data):
                do {
                    // Parse the JSON data
                    let response = try JSONDecoder().decode(CheckTransactionStatusResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    print(String(describing: error))
                    completion(.failure(error))
                }
            case .failure(let error):
                print(String(describing: error))
                completion(.failure(error))
            }
        })
    }
    
    
    func requestOTPForCardSaving(orderReference: String, phoneNumber: String, completion: @escaping (Result<RequestCardOTPResponse, Error>) -> Void){
        let url = URL(string:  "\(Constants.base_url)/checkout/user-card/auth/")!
        let paramaters : [String: Any] = ["orderReference": orderReference, "phoneNumber": phoneNumber]
        pingPonger(url: url, httpMethod: .POST, headers:  [:], bodyValues: paramaters, completion: { result in
            switch result {
            case .success(let data):
                do {
                    // Parse the JSON data
                    let response = try JSONDecoder().decode(RequestCardOTPResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    print(String(describing: error))
                    completion(.failure(error))
                }
            case .failure(let error):
                print(String(describing: error))
                completion(.failure(error))
            }
        })
    }
    
    
    func submitOTPForCardSaving(orderReference: String, phoneNumber: String, otp: String, completion: @escaping (Result<RequestCardOTPResponse, Error>) -> Void){
        let url = URL(string:  "\(Constants.base_url)/checkout/user-card/auth/")!
        let paramaters : [String: Any] = ["orderReference": orderReference, "phoneNumber": phoneNumber, "otp" : otp]
        pingPonger(url: url, httpMethod: .POST, headers: [:], bodyValues: paramaters, completion: { result in
            switch result {
            case .success(let data):
                do {
                    let response = try JSONDecoder().decode(RequestCardOTPResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    print(String(describing: error))
                    completion(.failure(error))
                }
            case .failure(let error):
                print(String(describing: error))
                completion(.failure(error))
            }
        })
        
    }
    
    
    func getFlashAccount(orderReference: String, completion: @escaping (Result<FlashAccountResponse, Error>) -> Void){
        let url = URL(string:  "\(Constants.base_url)/checkout/get-checkout-kta/\(orderReference)")!
        pingPonger(url: url, headers:  [:], completion: { result in
            switch result {
            case .success(let data):
                do {
                    // Parse the JSON data
                    let response = try JSONDecoder().decode(FlashAccountResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    print(String(describing: error))
                    completion(.failure(error))
                }
            case .failure(let error):
                print(String(describing: error))
                completion(.failure(error))
            }
        })
    }
    
    private func pingPonger(url: URL, httpMethod: HttpMethodAction = .GET, headers: [String: String], bodyValues : Dictionary<String, Any>? = nil, completion: @escaping (Result<Data, Error>) -> Void){
        let defaultDict : Dictionary = [
            "Content-Type": "application/json"
        ]
        
        let headerDict =  defaultDict.merging(headers) { $1 }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        for  (key, value) in headerDict {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        if let body = bodyValues {
            let requestBody = try! JSONSerialization.data(withJSONObject: body)
            request.httpBody = requestBody
        }
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
//            if let error = error {
//                print(error)
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data = data else {
//                print(error)
//                completion(.failure(error!))
//                return
//            }
//            
//            print(data)
//            completion(.success(data))
            
            
            guard let data = data, error == nil else {
                let errorString = error?.localizedDescription ?? "No data"
                Octane.errorString = errorString
                print(errorString)
                completion(.failure(error!))
                return
            }
            
            print("")
            print(url)
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
            }
            print(request.httpBody)
            print(request.httpMethod)
            print(request.allHTTPHeaderFields)
            print(bodyValues)
            
            print("")
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                Octane.errorString = responseJSON["description"] as? String ?? ""
                completion(.success(data))
            } else {
                completion(.success(data))
            }
        }
        

        task.resume()
    }
    
    
    
    
}
