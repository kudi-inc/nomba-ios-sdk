//
//  File.swift
//  
//
//  Created by Bezaleel Ashefor on 11/06/2024.
//

import Foundation
import UIKit
import CoreGraphics
import CoreText

class FontsManager {
    
    static var fontRegular : String = "TTInterfaces-Regular"
    static var fontMedium : String = "TTInterfaces-Medium"
    static var fontBold : String = "TTInterfaces-Bold"
    static var fontBlack : String = "TTInterfaces-Black"
    
    
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
