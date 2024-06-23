//
//  SwiftUIView.swift
//  
//
//  Created by Bezaleel Ashefor on 22/06/2024.
//

import SwiftUI

struct CardOTPView: View {
    @FocusState private var pinFocusState : FocusPinSix?
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""
    @State var pinFive: String = ""
    @State var pinSix: String = ""
    @Binding var otpMessage : String
    
    var body: some View {
        VStack(spacing: 30){
            Image("digits", bundle: .module)
            Text(otpMessage)
                .lineSpacing(2)
                .multilineTextAlignment(.center)
                .font(.custom(FontsManager.fontRegular, size: 16))
            HStack(spacing:8, content: {
                TextField("", text: $pinOne)
                    .modifier(OtpModifer(pin:$pinOne, onChanged: {_ in }))
                    .onChange(of:pinOne){newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .pinTwo
                        }
                    }
                    .focused($pinFocusState, equals: .pinOne)
                
                TextField("", text:  $pinTwo)
                    .modifier(OtpModifer(pin:$pinTwo, onChanged: {_ in }))
                    .onChange(of:pinTwo){newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .pinThree
                        }else {
                            if (newVal.count == 0) {
                                pinFocusState = .pinOne
                            }
                        }
                    }
                    .focused($pinFocusState, equals: .pinTwo)
                
                
                TextField("", text:$pinThree)
                    .modifier(OtpModifer(pin:$pinThree, onChanged: {_ in }))
                    .onChange(of:pinThree){newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .pinFour
                        }else {
                            if (newVal.count == 0) {
                                pinFocusState = .pinTwo
                            }
                        }
                    }
                    .focused($pinFocusState, equals: .pinThree)
                
                
                TextField("", text:$pinFour)
                    .modifier(OtpModifer(pin:$pinFour, onChanged: {_ in }))
                    .onChange(of:pinFour){newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .pinFive
                        }else {
                            if (newVal.count == 0) {
                                pinFocusState = .pinThree
                            }
                        }
                    }
                    .focused($pinFocusState, equals: .pinFour)
                
                TextField("", text:$pinFive)
                    .modifier(OtpModifer(pin:$pinFive, onChanged: {_ in }))
                    .onChange(of:pinFive){newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .pinSix
                        }else {
                            if (newVal.count == 0) {
                                pinFocusState = .pinFour
                            }
                        }
                    }
                    .focused($pinFocusState, equals: .pinFive)
                
                TextField("", text:$pinSix)
                    .modifier(OtpModifer(pin:$pinSix, onChanged: {_ in }))
                    .onChange(of:pinSix){newVal in
                        if (newVal.count == 0) {
                            pinFocusState = .pinFive
                        }
                    }
                    .focused($pinFocusState, equals: .pinSix)
            })
        }.foregroundStyle(Color("Text Primary", bundle: .module))
            .padding(.vertical, 60)
            .frame(maxWidth: .infinity)
            .overlay{
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("Neutral Two", bundle: .module), lineWidth: 1)
        }
    }
}

#Preview {
    CardOTPView(otpMessage: .constant("Enter the One Time Password (OTP)\n sent to **** *** **87 to verify it"))
}
