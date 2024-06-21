//
//  TransferPaymentStatus.swift
//
//
//  Created by Bezaleel Ashefor on 20/06/2024.
//

import Foundation

enum TransferPaymentStatus: Int {
    case DETAILS = 0
    case ACCOUNT_EXPIRED = 1
    case CONFIRMATION_WAITING = 2
    case CONFIRMATION_WAITING_FAILED = 3
    case GET_HELP = 4
    
}
