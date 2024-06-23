//
//  Util.swift
//
//
//  Created by Bezaleel Ashefor on 15/06/2024.
//

import Foundation
import Drops
import SwiftUI
import Combine

class Util {
    
    static func getDrop(message: String) -> Drop {
        return Drop(
            title: message,
            titleNumberOfLines: 2,
            action: .init {
                Drops.hideCurrent()
            }
        )
    }
    
    static func getDateComponents(isoDate: String) -> DateComponents{
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "MM/YY"
        let date = dateFormatter.date(from:isoDate)!
        print("Date Gotten \(isoDate)")
        print("Date Gotten \(date)")
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
        print(components)
        return components
    }
    
    static var isPreview: Bool {
        return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
    }
    
}

extension View {
    @ViewBuilder
    func valueChanged<T: Equatable>(value: T, onChange: @escaping (T) -> Void) -> some View {
        if #available(iOS 14.0, tvOS 14.0, macOS 11.0, watchOS 7.0, *) {
            self.onChange(of: value, perform: onChange)
        } else {
            self.onReceive(Just(value)) { value in
                onChange(value)
            }
        }
    }
}

extension String {
    
    func onlyNumbers() -> String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    var formattedCreditCard: String {
        return format(with: CardTextField.cardNumber, phone: self)
    }
    
    var formattedExpiredDate: String {
        return format(with: CardTextField.dateExpiration, phone: self)
    }
    
    var formattedCvv: String {
        return format(with: CardTextField.cvv, phone: self)
    }
    
    func format(with maskType: CardTextField, phone: String) -> String {
        let mask = maskType.mask
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                index = numbers.index(after: index)
                
            } else {
                result.append(ch)
            }
        }
        return result
    }
}





#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif

