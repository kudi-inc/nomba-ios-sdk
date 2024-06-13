//
//  FlashAccountResponse.swift
//
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import Foundation

struct FlashAccountResponse: Codable {
    let code, description: String
    let data: FlashAccountDataClass
}

// MARK: - DataClass
struct FlashAccountDataClass: Codable {
    let accountNumber, accountName, bankName: String
}
