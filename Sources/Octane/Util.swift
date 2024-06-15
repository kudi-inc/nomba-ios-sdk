//
//  File.swift
//  
//
//  Created by Bezaleel Ashefor on 15/06/2024.
//

import Foundation
import Drops

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
    
}