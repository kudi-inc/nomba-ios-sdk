//
//  CardTextField.swift
//  CardTFValidation
//
//

import Foundation

public enum CardTextField {
  case cardNumber
  case cvv
  case cardHolder
  case dateExpiration
  
  var mask: String {
    switch self {
    case .cardNumber:
      return "XXXX XXXX XXXX XXXX"
    case .cvv:
      return "XXX"
    case .cardHolder:
      return ""
    case .dateExpiration:
      return "XX/XX"
    }
  }
}
