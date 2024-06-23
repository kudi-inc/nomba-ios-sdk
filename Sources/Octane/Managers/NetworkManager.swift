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
    
    func getAccessToken(accountId: String, clientId: String, clientKey: String, selectedPaymentOption: PaymentOption, completion: @escaping (Result<Bool, Error>) -> Void){
        if (accessToken != nil || refreshToken != nil){
            completion(.success(true))
        } else {
            let url = URL(string:  "\(Constants.base_url)/auth/token/issue")!
            let body : [String : Any] = ["grant_type": "client_credentials", "client_id": "\(clientId)", "client_secret": "\(clientKey)"]
            pingPonger(url: url, httpMethod: .POST, headers: ["accountId": accountId], bodyValues: body, completion: { [self] result in
                switch result {
                case .success(let data):
                    do {
                        let accessTokenResult = try JSONDecoder().decode(AccessTokenResponse.self, from: data)
                        accessToken = accessTokenResult.data.accessToken
                        refreshToken = accessTokenResult.data.refreshToken
                        completion(.success(true))
                    } catch (let error) {
                        print(String(describing: error))
                        completion(.success(false))
                    }
                case .failure(let error):
                    print(String(describing: error))
                    completion(.failure(error))
                }
            })
        }
    }
    
    
    func createOrder(orderReference: String, customerId: String, customerEmail: String, callbackURL : String, amount: String, currency : String, accountId: String, selectedPaymentOption: PaymentOption, completion: @escaping (Result<CreateOrderResponse, Error>) -> Void){
        let url = URL(string:  "\(Constants.base_url)/checkout/order")!
    
        let order : [String: Any] = ["tokenizeCard": "true", "order": ["orderReference": "\(orderReference)", "customerId": "\(customerId)", "callbackUrl": "\(callbackURL)", "customerEmail": "\(customerEmail)", "amount": "\(amount)", "currency": "\(currency)"]]
        
        pingPonger(url: url, httpMethod: .POST, headers: ["accountId": accountId, "Authorization": accessToken!], bodyValues: order, completion: { result in
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
        
        //    {
        //      "cardDetails": "{\"cardCVV\": 11,\"cardExpiryMonth\": 3,\"cardExpiryYear\": 2050,\"cardNumber\": \"5190752909999995\",\"cardPin\": 1111}",
        //      "key": "<string>",
        //      "orderReference": "c4307d58-2513-41d8-b7f7-dfecd5f9fdbe",
        //      "saveCard": "true",
        //      "deviceInformation": {
        //        "httpBrowserLanguage": "en-GB",
        //        "httpBrowserJavaEnabled": "true",
        //        "httpBrowserJavaScriptEnabled": "true",
        //        "httpBrowserColorDepth": "30",
        //        "httpBrowserScreenHeight": "900",
        //        "httpBrowserScreenWidth": "1500",
        //        "httpBrowserTimeDifference": "-60",
        //        "userAgentBrowserValue": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)",
        //        "deviceChannel": "Browser"
        //      }
        //    }
    
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
        
        pingPonger(url: url, httpMethod: .POST, headers: ["Authorization": accessToken!], bodyValues: parameters, completion: { result in
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
    
    
    func checkTransactionOrderStatus(orderReference: String, completion: @escaping (Result<CheckTransactionStatusResponse, Error>) -> Void){
        let url = URL(string:  "\(Constants.base_url)/checkout/confirm-transaction-receipt/")!
        let paramaters : [String: Any] = ["orderReference": orderReference]
        pingPonger(url: url, httpMethod: .POST, headers: ["Authorization": accessToken!], bodyValues: paramaters, completion: { result in
            switch result {
            case .success(let data):
                do {
                    // Parse the JSON data
                    let response = try JSONDecoder().decode(CheckTransactionStatusResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    
    func getFlashAccount(orderReference: String, completion: @escaping (Result<FlashAccountResponse, Error>) -> Void){
        let url = URL(string:  "\(Constants.base_url)/checkout/get-checkout-kta/\(orderReference)")!
        pingPonger(url: url, headers: ["Authorization": accessToken!], completion: { result in
            switch result {
            case .success(let data):
                do {
                    // Parse the JSON data
                    let response = try JSONDecoder().decode(FlashAccountResponse.self, from: data)
                    completion(.success(response))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
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
