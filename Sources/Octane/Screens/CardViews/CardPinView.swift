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
    
    var body: some View {
        VStack{
            Image("lock", bundle: .module)
            HStack(spacing:15, content: {
                TextField("", text: $pinOne)
                    .modifier(OtpModifer(pin:$pinOne))
                    .onChange(of:pinOne){newVal in
                        if (newVal.count == 1) {
                            pinFocusState = .pinTwo
                        }
                    }
                    .focused($pinFocusState, equals: .pinOne)
                
                TextField("", text:  $pinTwo)
                    .modifier(OtpModifer(pin:$pinTwo))
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
                    .modifier(OtpModifer(pin:$pinThree))
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
                    .modifier(OtpModifer(pin:$pinFour))
                    .onChange(of:pinFour){newVal in
                        if (newVal.count == 0) {
                            pinFocusState = .pinThree
                        }
                    }
                    .focused($pinFocusState, equals: .pinFour)
                
                
            })
            .padding(.vertical)
        }.padding(.vertical, 60).frame(maxWidth: .infinity).overlay{
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("Neutral Two", bundle: .module), lineWidth: 1)
        }
    }
}

#Preview {
    CardPinView()
}
