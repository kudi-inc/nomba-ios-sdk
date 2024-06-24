//
//  CardSuccessView.swift
//  
//
//  Created by Bezaleel Ashefor on 23/06/2024.
//

import SwiftUI
import Drops

struct CardSuccessView: View {
    @State var logo : Image?
    var roundPadding : CGFloat = 15
    @Binding var parentPresentationMode : PresentationMode
    @State var isLoading = false
    @State private var progessAmount = 30.0
    @State private var progessTotal = 50.0
    @Binding var saveCard : Bool
    @State var otpPhoneNumber : String = ""
    @State var OTP : String = ""
    @State var cardSucessStatus : CardSuccessStatus = .SUCCESS
    @Binding var paymentOptionsViewModel : PaymentOptionsViewModel
    
    var body: some View {
        ZStack{
            VStack{
                TopView(logo: logo)
                switch (cardSucessStatus){
                case .SUCCESS:
                    CardSuccessMainView(saveCard: $saveCard, otpPhoneNumber: $otpPhoneNumber, parentPresentationMode: $parentPresentationMode, sendOTPAction: requestOTPForCardSaving)
                case .SUCCESS_OTP:
                    CardSuccessOTPView(otpPhoneNumber: $otpPhoneNumber, OTP: $OTP, onChangePhoneNumber: onChangePhoneNumber, onOTPEnteredAction: submitOTPForCardSaving, sendOTPAction: requestOTPForCardSaving)
                case .SUCCESS_OTP_SUCCESS:
                    CardSuccessOTPSuccess(parentPresentationMode: $parentPresentationMode)
                }
                Spacer()
                FooterView()
            }
            .padding(roundPadding)
            .font(.custom(FontsManager.fontRegular, size: 14))
            .foregroundStyle(Color("Text Primary", bundle: .module))
            if (isLoading){
                LoaderView()
            }
        }
    }
    
    func onChangePhoneNumber(){
        cardSucessStatus = .SUCCESS
    }
    
    func requestOTPForCardSaving(){
        hideKeyboard()
        isLoading = true
        paymentOptionsViewModel.requestOTPForCardSaving(phoneNumber: otpPhoneNumber, completion: { result in
            switch result {
            case .success(let data):
                isLoading = false
                if (data.code == "00"){
                    cardSucessStatus = .SUCCESS_OTP
                } else {
                    let errorString = data.data.message
                    Drops.show(Util.getDrop(message: errorString))
                }
            case .failure(let error):
                isLoading = false
                if (Octane.errorString.isEmpty) {
                    let errorString = "Something went wrong. Try again" + error.localizedDescription
                    Drops.show(Util.getDrop(message: errorString))
                } else {
                    let errorString = Octane.errorString
                    Drops.show(Util.getDrop(message: errorString))
                }
            }
        })
    }
    
    func submitOTPForCardSaving(){
        hideKeyboard()
        isLoading = true
        paymentOptionsViewModel.submitOTPForCardSaving(phoneNumber: otpPhoneNumber, otp: OTP, completion: { result in
            switch result {
            case .success(let data):
                isLoading = false
                if (data.code == "00"){
                    cardSucessStatus = .SUCCESS_OTP_SUCCESS
                } else {
                    let errorString = data.data.message
                    Drops.show(Util.getDrop(message: errorString))
                }
            case .failure(let error):
                isLoading = false
                if (Octane.errorString.isEmpty) {
                    let errorString = "Something went wrong. Try again" + error.localizedDescription
                    Drops.show(Util.getDrop(message: errorString))
                } else {
                    let errorString = Octane.errorString
                    Drops.show(Util.getDrop(message: errorString))
                }
            }
        })
    }
}

#Preview {
    @Environment(\.presentationMode) var presentationMode
    return CardSuccessView(parentPresentationMode: presentationMode, saveCard: .constant(true), paymentOptionsViewModel: .constant(PaymentOptionsViewModel()))
}
