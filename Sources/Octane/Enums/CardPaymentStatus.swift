//
//  CardPaymentStatus.swift
//
//
//  Created by Bezaleel Ashefor on 22/06/2024.
//

import Foundation

enum CardPaymentStatus : Int{
    case DETAILS = 0
    case CARD_LOADING = 1
    case CARD_PIN = 2
    case CARD_OTP = 3
}
