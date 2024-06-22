//
//  File.swift
//  
//
//  Created by Bezaleel Ashefor on 22/06/2024.
//

import Foundation

// MARK: - CheckTransactionStatusResponse
struct CheckTransactionStatusResponse: Codable {
    let code, description: String
    let data: CheckTransactionDataClass
}



// MARK: - DataClass
struct CheckTransactionDataClass: Codable {
    let status, message: String
    let order: Order
}

// MARK: - Order
struct Order: Codable {
    let orderID, orderReference, customerID, accountID: String
    let callbackURL, customerEmail, amount, currency: String
    let businessName, businessEmail, businessLogo: String

    enum CodingKeys: String, CodingKey {
        case orderID = "orderId"
        case orderReference
        case customerID = "customerId"
        case accountID = "accountId"
        case callbackURL = "callbackUrl"
        case customerEmail, amount, currency, businessName, businessEmail, businessLogo
    }
}
