//
//  SubmitOTPResponse.swift
//
//
//  Created by Bezaleel Ashefor on 23/06/2024.
//

import Foundation

// MARK: - SubmitOTPResponse
struct SubmitOTPResponse: Codable {
    let code, description: String
    let data: SubmitOTPDataClass
}

// MARK: - DataClass
struct SubmitOTPDataClass: Codable {
    let message: String
    let status : Bool
}
