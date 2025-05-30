//
//  File.swift
//  
//
//  Created by Bezaleel Ashefor on 22/06/2024.
//

import Foundation

// MARK: - CheckTransactionStatusResponse
public struct CheckTransactionStatusResponse: Codable {
    let code, description: String
    let data: CheckTransactionDataClass
}



// MARK: - DataClass
struct CheckTransactionDataClass: Codable {
    let message: String
    let order: Order
    let status: Bool
}

// MARK: - Order
struct Order: Codable {
    let orderID, orderReference, customerID, accountID: String
    let callbackURL, customerEmail, amount, currency: String
    let businessName, businessEmail : String
    let businessLogo: String?

    enum CodingKeys: String, CodingKey {
        case orderID = "orderId"
        case orderReference
        case customerID = "customerId"
        case accountID = "accountId"
        case callbackURL = "callbackUrl"
        case customerEmail, amount, currency, businessName, businessEmail, businessLogo
    }
}
