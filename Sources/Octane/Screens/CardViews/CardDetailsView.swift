//
//  SwiftUIView.swift
//  
//
//  Created by Bezaleel Ashefor on 22/06/2024.
//

import SwiftUI

struct CardDetailsView: View {
    @Binding var creditCardNumber : String
    @Binding var creditCardExpDate : String
    @Binding var creditCardCCV : String
    @Binding var saveCard : Bool
    @Environment(\.presentationMode) var presentationMode
    var cancelPayment : () -> () = {}
    var onPayButtonAction : () -> () = {}
    
    @State private var isCardValid = false
    @State private var isDateValid = false
    @State private var isCVVValid = false
    @State private var cardType = CardBankType.nonIdentified
    
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack{
                VStack(spacing: 0){
                    Text("Enter your card information for payment")
                        .lineSpacing(2)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10)
                    Spacer().frame(height: 15)
                    HStack{
                        VStack(alignment: .leading, spacing: 4){
                            Text("Card number").font(.custom(FontsManager.fontRegular, size: 12))
                                .foregroundStyle(Color("Neutral Eight", bundle: .module))
                            CardValidationTF(
                                      text: $creditCardNumber,
                                      isValid: $isCardValid,
                                      bankCardType: $cardType,
                                      tfType: .cardNumber,
                                      tfFont: .custom(FontsManager.fontRegular, size: 16),
                                      tfColor: Color("Text Primary", bundle: .module),
                                      prompt: Text("0000 0000 0000 0000").foregroundColor(Color("Neutral Four", bundle: .module))
                                      )
                        }
                        Spacer()
                        Image("PaymentIcon", bundle: .module)
                    }.padding(.vertical, 12).padding(.horizontal, 16)
                        .background(Color("Neutral One", bundle: .module))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay{
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color("Neutral Two", bundle: .module), lineWidth: 1)
                        }
                    Spacer().frame(height: 16)
                    HStack(spacing: 15){
                        HStack{
                            VStack(alignment: .leading, spacing: 4){
                                Text("Expiry date")
                                    .font(.custom(FontsManager.fontRegular, size: 12))
                                    .foregroundStyle(Color("Neutral Eight", bundle: .module))
                                CardValidationTF(
                                          text: $creditCardExpDate,
                                          isValid: $isDateValid,
                                          bankCardType: $cardType,
                                          tfType: .dateExpiration,
                                          tfFont: .custom(FontsManager.fontRegular, size: 16),
                                          tfColor: Color("Text Primary", bundle: .module),
                                          prompt: Text("MM/YY").foregroundColor(Color("Neutral Four", bundle: .module))
                                          )
                            }
                            Spacer()
                        }.padding(.vertical, 12).padding(.horizontal, 16)
                            .background(Color("Neutral One", bundle: .module))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay{
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("Neutral Two", bundle: .module), lineWidth: 1)
                            }
                        
                        HStack{
                            VStack(alignment: .leading, spacing: 4){
                                Text("CVV").font(.custom(FontsManager.fontRegular, size: 12))
                                    .foregroundStyle(Color("Neutral Eight", bundle: .module))
                                CardValidationTF(
                                          text: $creditCardCCV,
                                          isValid: $isCVVValid,
                                          bankCardType: $cardType,
                                          tfType: .cvv,
                                          tfFont: .custom(FontsManager.fontRegular, size: 16),
                                          tfColor: Color("Text Primary", bundle: .module),
                                          prompt: Text("None").foregroundColor(Color("Neutral Four", bundle: .module))
                                          )
                            }
                            Spacer()
                        }.padding(.vertical, 12).padding(.horizontal, 16)
                            .background(Color("Neutral One", bundle: .module))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay{
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color("Neutral Two", bundle: .module), lineWidth: 1)
                            }
                    }
                    Spacer().frame(height: 18)
                    Toggle(isOn: $saveCard) {
                        Text("Save card for future use")
                    }.padding(.horizontal, 5)
                }.toolbar {
                    ToolbarItem(placement: .keyboard) {
                        Button(action: {
                            hideKeyboard()
                        }) {
                            Text("Done").padding().foregroundStyle(Color("Text Primary", bundle: .module))
                        }
                    }
                }.frame(maxWidth: .infinity, alignment: .leading)
                Spacer().frame(height: 30)
                YellowButton(buttonText: "Pay \(Octane.shared.getAmountFormatedWithCurrency())", action: {
                    showCardPinView()
                }).opacity(isCVVValid && isDateValid && isCardValid ? 1.0 : 0.3).disabled(isCVVValid && isDateValid && isCardValid ? false : true)
                Spacer().frame(height: 24)
                Divider()
                Spacer().frame(height: 24)
                BorderButton(buttonText: "Change payment method", action: {
                    presentationMode.wrappedValue.dismiss()
                })
                NoBorderButton(buttonText: "Cancel payment", action: {
                    cancelPayment()
                })
                Spacer().frame(height: 50)
            }
        }
    }
    
    func showCardPinView(){
        if (isCVVValid && isDateValid && isCardValid){
            onPayButtonAction()
            print("check")
        }
    }
}

#Preview {
    CardDetailsView(creditCardNumber: .constant(""), creditCardExpDate: .constant(""), creditCardCCV: .constant(""), saveCard: .constant(false))
}
