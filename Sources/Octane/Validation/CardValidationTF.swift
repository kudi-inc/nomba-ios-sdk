//
//  CardValidationTF.swift
//  CardTFValidation
//
//

import SwiftUI

public struct CardValidationTF: View {
  
  @Binding private var text: String
  @Binding private var isValid: Bool
  @Binding private var bankCardType: CardBankType
  private let tfType: CardTextField
  private let tfFont: Font
  private let tfColor: Color
  private let subtitle: String
    private let prompt: Text?
  
  public init(
    text: Binding<String>,
    isValid: Binding<Bool>,
    bankCardType: Binding<CardBankType>,
    tfType: CardTextField,
    tfFont: Font = Font.title,
    tfColor: Color = .black.opacity(0.9),
    prompt: Text?,
    subtitle: String = ""
  ) {
    self._text = text
    self._isValid = isValid
    self._bankCardType = bankCardType
    self.tfType = tfType
    self.tfFont = tfFont
    self.tfColor = tfColor
    self.subtitle = subtitle
      self.prompt = prompt
  }
  
  public var body: some View {
    switch tfType {
    case .cardNumber:
      cardNumberView()
    case .cvv:
      cvvView()
    case .cardHolder:
      cardHolderView()
    case .dateExpiration:
      dateExpirationView()
    }
  }
  
  @ViewBuilder
  private func cardNumberView() -> some View {
    TextField(subtitle, text: $text, prompt: prompt)
      .font(tfFont)
      .foregroundColor(tfColor)
      .valueChanged(value: text) { number in
        self.text = number.formattedCreditCard
        withAnimation(.linear) {
          self.isValid = CardValidationTF.isCardNumberValid(text)
          self.bankCardType = CardValidationTF.cardType(from: text)
        }
      }
  }
  
  @ViewBuilder
  private func cvvView() -> some View {
    TextField(subtitle, text: $text, prompt: prompt)
      .font(tfFont)
      .foregroundColor(tfColor)
      .valueChanged(value: text) { cvv in
        self.text = cvv.formattedCvv
        withAnimation(.linear) {
          self.isValid = CardValidationTF.isCvvValid(text)
        }
      }
  }
  
  @ViewBuilder
  private func dateExpirationView() -> some View {
    TextField(subtitle, text: $text, prompt: prompt)
      .font(tfFont)
      .foregroundColor(tfColor)
      .valueChanged(value: text) { date in
        self.text = date.formattedExpiredDate
        withAnimation(.linear) {
          self.isValid = CardValidationTF.isExpDateValid(text)
        }
      }
  }
  
  @ViewBuilder
  private func cardHolderView() -> some View {
    TextField(subtitle, text: $text, prompt: prompt)
      .font(tfFont)
      .foregroundColor(tfColor)
      .valueChanged(value: text) { name in
        withAnimation(.linear) {
          self.isValid = name != "" ? true : false
        }
      }
  }
}


