//
//  SwiftUIView.swift
//  
//
//  Created by Bezaleel Ashefor on 23/06/2024.
//

import SwiftUI

struct CardSuccessOTPView: View {
    @Binding var otpPhoneNumber : String
    @FocusState private var pinFocusState : FocusPin?
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""
    @Binding var OTP : String
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var timeRemaining = 60
    @State private var resendOTP = false
    @State var resendMessage = ""
    var onChangePhoneNumber : () -> () = {}
    var onOTPEnteredAction : () -> () = {}
    var sendOTPAction : () -> () = {}
    
    var body: some View {
        ScrollView(showsIndicators: false){
            VStack(spacing: 20){
                Image("digits", bundle: .module)
                Text("Enter the One Time Password (OTP)\nsent to \(otpPhoneNumber)")
                    .padding(.horizontal)
                    .lineSpacing(2)
                    .multilineTextAlignment(.center)
                    .font(.custom(FontsManager.fontRegular, size: 16))
                Spacer().frame(height: 5)
                HStack(spacing:15, content: {
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
                            if (newVal.count == 0) {
                                pinFocusState = .pinThree
                            } else {
                                OTP = "\(pinOne)\(pinTwo)\(pinThree)\(pinFour)"
                                // doActionHere
                                onOTPEnteredAction()
                            }
                        }
                        .focused($pinFocusState, equals: .pinFour)
                })
                NoBorderBindingButton(buttonText: $resendMessage, action: {
                    if (resendOTP){
                        sendOTPAction()
                        resendOTP = false
                        timeRemaining = 60
                    }
                }).disabled(!resendOTP)
                BorderButton(buttonText: "Change Phone Number", action: onChangePhoneNumber)
            }.onReceive(timer) { time in
                guard isActive else { return }
                
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    resendMessage = "Resend OTP in \(printSecondsToHoursMinutesSeconds(timeRemaining)) secs"
                } else {
                    resendMessage = "Resend OTP"
                    resendOTP = true
                }
            }.onChange(of: scenePhase){ value in
                if value == .active {
                    isActive = true
                } else {
                    isActive = false
                }
            }
        }
    }
    
    private func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    private func printSecondsToHoursMinutesSeconds(_ seconds: Int) -> String {
        let (_, _, s) = secondsToHoursMinutesSeconds(seconds)
        return String(format: "%02d", s)
    }
}

#Preview {
    CardSuccessOTPView(otpPhoneNumber: .constant("09012345678"), OTP: .constant(""))
}
