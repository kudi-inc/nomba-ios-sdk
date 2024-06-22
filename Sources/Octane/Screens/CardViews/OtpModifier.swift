//
//  OtpModifer.swift
//
//
//  Created by Bezaleel Ashefor on 22/06/2024.
//

import Foundation
import SwiftUI
import Combine

struct OtpModifer: ViewModifier {

    @Binding var pin : String

    var textLimt = 1

    func limitText(_ upper : Int) {
        if pin.count > upper {
            let value = Int(pin.prefix(upper)) ?? 0
            print(value)
            self.pin = String(value)
        }
    }


    //MARK -> BODY
    func body(content: Content) -> some View {
        content
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .onReceive(Just(pin)) {_ in limitText(textLimt)}
            .frame(width: 45, height: 45)
            .background(Color.white.cornerRadius(5))
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("Neutral Two", bundle: .module), lineWidth: 2)
            )
    }
}
