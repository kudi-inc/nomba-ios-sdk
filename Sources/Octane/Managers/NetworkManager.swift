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
            print("\(clientId)")
            print("\(clientKey)")
            let body = "{\"grant_type\": \"client_credentials\", \"client_id\": \"\(clientId)\", \"client_secret\": \"\(clientKey)\"}"
            pingPonger(url: url, httpMethod: "POST", headers: ["accountId": accountId], bodyValues: body, completion: { [self] result in
                switch result {
                case .success(let data):
                    do {
                        let accessTokenResult = try JSONDecoder().decode(AccessTokenResponse.self, from: data)
                        accessToken = accessTokenResult.data.accessToken
                        refreshToken = accessTokenResult.data.refreshToken
                        completion(.success(true))
                    } catch {
                        refreshToken = ""
                        accessToken = ""
                        completion(.success(false))
                    }
                case .failure(let error):
                    refreshToken = ""
                    accessToken = ""
                    completion(.failure(error))
                }
            })
        }
    }
    
    
    func createOrder(orderReference: String, customerId: String, customerEmail: String, callbackURL : String, amount: String, currency : String, accountId: String, selectedPaymentOption: PaymentOption, completion: @escaping (Result<CreateOrderResponse, Error>) -> Void){
        let url = URL(string:  "\(Constants.base_url)/checkout/order")!
        
//        {
//          "order": {
//            "orderReference": "90e81e8a-bc14-4ebf-89c0-57da752cca58",
//            "customerId": "762878332454",
//            "callbackUrl": "https://ip:port/merchant.com/callback",
//            "customerEmail": "abcde@gmail.com",
//            "amount": "10000.00",
//            "currency": "NGN"
//          },
//          "tokenizeCard": "true"
//        }
        
        let order = "{\"orderReference\": \"\(orderReference)\", \"customerId\": \"\(customerId)\", \"callbackUrl\": \"\(callbackURL)\"}, \"customerEmail\": \"\(customerEmail)\", \"amount\": \"\(amount)\", \"currency\": \"\(currency)\"}"
        let body = "{\"tokenizeCard\": \"true\", \"order\": \"\(order)\"}"
        pingPonger(url: url, httpMethod: "POST", headers: ["accountId": accountId, "Authorization": accessToken!], completion: { result in
            switch result {
            case .success(let data):
                do {
                    // Parse the JSON data
                    let createOrderResponse = try JSONDecoder().decode(CreateOrderResponse.self, from: data)
                    completion(.success(createOrderResponse))
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
        pingPonger(url: url, httpMethod: "POST", headers: ["Authorization": accessToken!], completion: { result in
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
    
    private func pingPonger(url: URL, httpMethod: String = "GET", headers: [String: String], bodyValues : String? = nil, completion: @escaping (Result<Data, Error>) -> Void){
        var defaultDict : Dictionary = [
            "Content-Type": "application/json"
        ]
        
        let headerDict =  defaultDict.merging(headers) { $1 }
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headerDict
        
        if let body = bodyValues {
            let bodyJson = body.data(using: .utf8)
            request.httpBody = bodyJson
            print(request.httpBody)
        }
        
        print("start")
        print(request.httpMethod)
        print(request.allHTTPHeaderFields)
        print(bodyValues)
        print(url)
        
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
                print(error?.localizedDescription ?? "No data")
                completion(.failure(error!))
                return
            }
            
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
                completion(.success(data))
            }
        }
        
        print("end")
        task.resume()
    }
    
    
    
    
}
