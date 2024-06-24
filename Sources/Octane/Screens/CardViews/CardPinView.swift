//
//  CardPinView.swift
//
//
//  Created by Bezaleel Ashefor on 22/06/2024.
//

import SwiftUI


struct CardPinView: View {
    @FocusState private var pinFocusState : FocusPin?
    @State var pinOne: String = ""
    @State var pinTwo: String = ""
    @State var pinThree: String = ""
    @State var pinFour: String = ""
    @Binding var cardPin : String
    
    var onPinEnteredAction : () -> () = {}
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30){
                Image("lock", bundle: .module)
                Text("Please enter your 4-digit card PIN to\n complete transaction")
                    .lineSpacing(2)
                    .multilineTextAlignment(.center).padding(.horizontal)
                    .font(.custom(FontsManager.fontRegular, size: 16))
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
                                cardPin = "\(pinOne)\(pinTwo)\(pinThree)\(pinFour)"
                                // doActionHere
                                onPinEnteredAction()
                            }
                        }
                        .focused($pinFocusState, equals: .pinFour)
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
}

#Preview {
    CardPinView(cardPin: .constant(""))
}
