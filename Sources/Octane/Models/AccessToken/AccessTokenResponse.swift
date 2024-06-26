//
//  AccessTokenResponse.swift
//
//
//  Created by Bezaleel Ashefor on 13/06/2024.
//

import Foundation

struct AccessTokenResponse: Codable {
    let code, description: String
    let data: DataClass
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case code
        case description
    }
}

// MARK: - DataClass
struct DataClass: Codable {
    let businessID, accessToken, refreshToken: String
    let expiresAt: String

    enum CodingKeys: String, CodingKey {
        case businessID = "businessId"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresAt
    }
}
