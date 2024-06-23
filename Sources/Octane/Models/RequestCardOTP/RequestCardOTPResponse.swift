//
//  RequestCardOTPResponse.swift
//
//
//  Created by Bezaleel Ashefor on 23/06/2024.
//

import Foundation

// MARK: - RequestCardOTPResponse
struct RequestCardOTPResponse: Codable {
    let code, description: String
    let data: RequestCardDataClass
}

// MARK: - DataClass
struct RequestCardDataClass: Codable {
    let success, message: String
}
