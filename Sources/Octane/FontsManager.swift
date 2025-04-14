//
//  File.swift
//  
//
//  Created by Bezaleel Ashefor on 11/06/2024.
//

/// https://blog.bontouch.com/news-and-insights/custom-fonts-in-a-swift-package/


import Foundation
import UIKit
import CoreGraphics
import CoreText

class FontsManager {
    
    static var fontRegular : String = "Inter-Regular"
    static var fontMedium : String = "Inter-Medium"
    static var fontBold : String = "Inter-Bold"
    static var fontBlack : String = "Inter-Black"
    
    
    public enum FontError: Swift.Error {
       case failedToRegisterFont
    }

    func registerFont(named name: String) {
        do {
            guard let asset = NSDataAsset(name: "Fonts/\(name)", bundle: Bundle.module) else {
                throw FontError.failedToRegisterFont
            }

            guard let provider = CGDataProvider(data: asset.data as NSData) else {
                throw FontError.failedToRegisterFont
            }

            guard let font = CGFont(provider) else {
                throw FontError.failedToRegisterFont
            }

            if !CTFontManagerRegisterGraphicsFont(font, nil) {
                throw FontError.failedToRegisterFont
            }

            print("✅ Font \(name) registered successfully.")

        } catch {
            print("❌ Failed to register font '\(name)': \(error)")
        }
    }

    
}
