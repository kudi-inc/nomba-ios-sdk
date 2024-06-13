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

    func registerFont(named name: String) throws {
       guard let asset = NSDataAsset(name: "Fonts/\(name)", bundle: Bundle.module),
          let provider = CGDataProvider(data: asset.data as NSData),
          let font = CGFont(provider),
          CTFontManagerRegisterGraphicsFont(font, nil) else {
        throw FontError.failedToRegisterFont
       }
    }
    
}
