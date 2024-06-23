//
//  SubmitCardDetailsResponse.swift
//
//
//  Created by Bezaleel Ashefor on 23/06/2024.
//

import Foundation

// MARK: - SubmitCardDetailsResponse
struct SubmitCardDetailsResponse: Codable {
    let code, description: String
    let data: SubmitCardDataClass
}

// MARK: - DataClass
struct SubmitCardDataClass: Codable {
    let message, responseCode, transactionID: String
    let status : Bool
    let secureAuthenticationData: SecureAuthenticationData?

    enum CodingKeys: String, CodingKey {
        case status, message, responseCode
        case transactionID = "transactionId"
        case secureAuthenticationData
    }
}

// MARK: - SecureAuthenticationData
struct SecureAuthenticationData: Codable {
    let jwt, md, acsURL, termURL: String

    enum CodingKeys: String, CodingKey {
        case jwt, md
        case acsURL = "acsUrl"
        case termURL = "termUrl"
    }
}
