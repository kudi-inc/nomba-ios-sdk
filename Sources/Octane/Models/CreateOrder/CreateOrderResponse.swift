//
//  CreateOrderResponse.swift
//
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import Foundation

// MARK: - CreateOrderResponse
struct CreateOrderResponse: Codable {
    let code, description: String
    let data: CreateOrderDataClass
}

// MARK: - DataClass
struct CreateOrderDataClass: Codable {
    let checkoutLink, orderReference: String
}
