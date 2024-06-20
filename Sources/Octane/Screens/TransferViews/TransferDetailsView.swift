//
//  SwiftUIView.swift
//
//
//  Created by Bezaleel Ashefor on 20/06/2024.
//

import SwiftUI
import Drops

struct TransferDetailsView: View {
    @Binding var accountNumber : String
    @Binding var bankName : String
    @Binding var accountName : String
    @State private var progessAmount = 0.0
    @State private var progessTotal : Double = 1800
    @State private var timeRemaining = 1800
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @Environment(\.presentationMode) var presentationMode
    var onTimerFinished : () -> () = {}
    let pasteboard = UIPasteboard.general
    
    var body: some View {
        VStack{
            VStack(spacing: 0){
                Text("Transfer to account details below")
                    .lineSpacing(2)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 10)
                Spacer().frame(height: 15)
                HStack{
                    VStack(alignment: .leading, spacing: 4){
                        Text("Account Number").font(.custom(FontsManager.fontRegular, size: 12))
                            .foregroundStyle(Color("Neutral Eight", bundle: .module))
                        Text(accountNumber)
                    }
                    Spacer()
                    Button(action: {
                        
                        pasteboard.string = accountNumber
                        Drops.show("Account number copied")
                    }){
                        Text("COPY").font(.custom(FontsManager.fontRegular, size: 10))
                            .padding(.vertical, 7)
                            .padding(.horizontal, 10)
                            .background(Color("Neutral One", bundle: .module))
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .contentShape(Rectangle())
                    }
                }.padding(.vertical, 12).padding(.horizontal, 16)
                    .overlay{
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color("Blue Two", bundle: .module), lineWidth: 1)
                    }.onTapGesture {
                        
                        pasteboard.string = accountNumber
                        Drops.show("Account number copied")
                    }
                Spacer().frame(height: 16)
                HStack{
                    VStack(alignment: .leading, spacing: 4){
                        Text("Bank Name")
                            .font(.custom(FontsManager.fontRegular, size: 12))
                            .foregroundStyle(Color("Neutral Eight", bundle: .module))
                        Text(bankName)
                    }
                    Spacer()
                    VStack(alignment: .leading, spacing: 4){
                        Text("Account Name")
                            .font(.custom(FontsManager.fontRegular, size: 12))
                            .foregroundStyle(Color("Neutral Eight", bundle: .module))
                        Text(accountName)
                    }
                }.padding(.vertical, 12).padding(.horizontal, 16)
                    .background(Color("Blue One", bundle: .module))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                Spacer().frame(height: 16)
                HStack{
                    VStack(alignment: .leading, spacing: 4){
                        Text("Amount").font(.custom(FontsManager.fontRegular, size: 12))
                            .foregroundStyle(Color("Neutral Eight", bundle: .module))
                        Text("\(Octane.shared.getAmountFormatedWithCurrency())")
                    }
                    Spacer()
                }.padding(.vertical, 12).padding(.horizontal, 16)
                    .background(Color("Blue One", bundle: .module))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                
            }.frame(maxWidth: .infinity, alignment: .leading)
            Spacer().frame(height: 20)
            VStack(spacing: 10){
                Text("Use this account only for this transaction")
                    .font(.custom(FontsManager.fontRegular, size: 12))
                HStack(alignment: .center, spacing: 5){
                    Text("Expires in")
                        .font(.custom(FontsManager.fontRegular, size: 12))
                    Text(printSecondsToHoursMinutesSeconds(timeRemaining))
                        .font(.custom(FontsManager.fontBold, size: 12)).foregroundStyle(Color("0E9C00", bundle: .module))
                    Image("clock", bundle: .module)
                    ProgressView(value: progessAmount, total: progessTotal).frame(width: 80).tint(Color("Button Primary", bundle: .module))
                }
            }
            Spacer().frame(height: 24)
            YellowButton(buttonText: "I have sent the money", action: {
                
            })
            Spacer().frame(height: 24)
            BorderButton(buttonText: "Change payment method", action: {
                presentationMode.wrappedValue.dismiss()
            })
            NoBorderButton(buttonText: "Cancel payment", action: {
                presentationMode.wrappedValue.dismiss()
            })
        }.onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
                progessAmount += 1
            } else {
                // it's ended
                onTimerFinished()
            }
        }.onChange(of: scenePhase){ value in
            if value == .active {
                isActive = true
            } else {
                isActive = false
            }
        }.onAppear(perform: {
            progessTotal = Double(timeRemaining)
        })
    }
    
    func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
        return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func printSecondsToHoursMinutesSeconds(_ seconds: Int) -> String {
        let (_, m, s) = secondsToHoursMinutesSeconds(seconds)
        return String(format: "%02d", m) + ":" + String(format: "%02d", s)
    }
}

#Preview {
    TransferDetailsView(accountNumber: .constant("98762371891"), bankName: .constant("Amucha MFB"), accountName: .constant("Abdullahi Abodunrin"))
}
