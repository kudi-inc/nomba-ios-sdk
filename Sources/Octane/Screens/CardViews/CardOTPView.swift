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
    @Binding var otpPin : String
    var onOtpEnteredAction : () -> () = {}
    
    var body: some View {
        ScrollView (showsIndicators: false) {
            VStack(spacing: 30){
                Image("digits", bundle: .module)
                Text(otpMessage)
                    .padding(.horizontal)
                    .lineSpacing(2)
                    .multilineTextAlignment(.center)
                    .font(.custom(FontsManager.fontRegular, size: 16))
                HStack(spacing:8, content: {
                    TextField("", text: $pinOne)
                        .modifier(OtpModifer(pin:$pinOne, onChanged: {_ in }))
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .onChange(of:pinOne){ newVal in
                            if newVal.count > 1 {
                                applyPastedCode(newVal)
                                return
                            }
                            if newVal.count == 1 {
                                pinFocusState = .pinTwo
                            }
                        }
                        .focused($pinFocusState, equals: .pinOne)
                    
                    TextField("", text:  $pinTwo)
                        .modifier(OtpModifer(pin:$pinTwo, onChanged: {_ in }))
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .onChange(of:pinTwo){ newVal in
                            if newVal.count > 1 {
                                applyPastedCode(newVal)
                                return
                            }
                            if newVal.count == 1 {
                                pinFocusState = .pinThree
                            } else {
                                if newVal.count == 0 {
                                    pinFocusState = .pinOne
                                }
                            }
                        }
                        .focused($pinFocusState, equals: .pinTwo)
                    
                    
                    TextField("", text:$pinThree)
                        .modifier(OtpModifer(pin:$pinThree, onChanged: {_ in }))
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .onChange(of:pinThree){ newVal in
                            if newVal.count > 1 {
                                applyPastedCode(newVal)
                                return
                            }
                            if newVal.count == 1 {
                                pinFocusState = .pinFour
                            } else {
                                if newVal.count == 0 {
                                    pinFocusState = .pinTwo
                                }
                            }
                        }
                        .focused($pinFocusState, equals: .pinThree)
                    
                    
                    TextField("", text:$pinFour)
                        .modifier(OtpModifer(pin:$pinFour, onChanged: {_ in }))
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .onChange(of:pinFour){ newVal in
                            if newVal.count > 1 {
                                applyPastedCode(newVal)
                                return
                            }
                            if newVal.count == 1 {
                                pinFocusState = .pinFive
                            } else {
                                if newVal.count == 0 {
                                    pinFocusState = .pinThree
                                }
                            }
                        }
                        .focused($pinFocusState, equals: .pinFour)
                    
                    TextField("", text:$pinFive)
                        .modifier(OtpModifer(pin:$pinFive, onChanged: {_ in }))
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .onChange(of:pinFive){ newVal in
                            if newVal.count > 1 {
                                applyPastedCode(newVal)
                                return
                            }
                            if newVal.count == 1 {
                                pinFocusState = .pinSix
                            } else {
                                if newVal.count == 0 {
                                    pinFocusState = .pinFour
                                }
                            }
                        }
                        .focused($pinFocusState, equals: .pinFive)
                    
                    TextField("", text:$pinSix)
                        .modifier(OtpModifer(pin:$pinSix, onChanged: {_ in }))
                        .keyboardType(.numberPad)
                        .textContentType(.oneTimeCode)
                        .onChange(of:pinSix){ newVal in
                            if newVal.count > 1 {
                                applyPastedCode(newVal)
                                return
                            }
                            if newVal.count == 0 {
                                pinFocusState = .pinFive
                            } else {
                                otpPin = "\(pinOne)\(pinTwo)\(pinThree)\(pinFour)\(pinFive)\(pinSix)"
                                onOtpEnteredAction()
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
    
    private func applyPastedCode(_ string: String) {
        let digits = string.filter { $0.isNumber }
        guard !digits.isEmpty else { return }
        let chars = Array(digits)
        pinOne = chars.count > 0 ? String(chars[0]) : ""
        pinTwo = chars.count > 1 ? String(chars[1]) : ""
        pinThree = chars.count > 2 ? String(chars[2]) : ""
        pinFour = chars.count > 3 ? String(chars[3]) : ""
        pinFive = chars.count > 4 ? String(chars[4]) : ""
        pinSix = chars.count > 5 ? String(chars[5]) : ""
        if chars.count >= 6 {
            otpPin = "\(pinOne)\(pinTwo)\(pinThree)\(pinFour)\(pinFive)\(pinSix)"
            onOtpEnteredAction()
        } else {
            if pinOne.isEmpty { pinFocusState = .pinOne }
            else if pinTwo.isEmpty { pinFocusState = .pinTwo }
            else if pinThree.isEmpty { pinFocusState = .pinThree }
            else if pinFour.isEmpty { pinFocusState = .pinFour }
            else if pinFive.isEmpty { pinFocusState = .pinFive }
            else { pinFocusState = .pinSix }
        }
    }
}

#Preview {
    CardOTPView(otpMessage: .constant("Enter the One Time Password (OTP)\n sent to **** *** **87 to verify it"), otpPin: .constant(""))
}
