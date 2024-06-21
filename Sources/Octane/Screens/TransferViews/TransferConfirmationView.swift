//
//  SwiftUIView.swift
//  
//
//  Created by Bezaleel Ashefor on 20/06/2024.
//

import SwiftUI

struct TransferConfirmationView: View {
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @Environment(\.scenePhase) var scenePhase
    @State private var isActive = true
    @State private var progessAmount = 0.0
    @State private var progessTotal : Double = 600
    @State private var timeRemaining = 600
    @Environment(\.presentationMode) var presentationMode
    var onTimerEndedAction : () -> () = {}
    var onHelpAction : () -> () = {}
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Text("Please wait. We are confirming your payment, \nIt might take a few minutes...")
                    .lineSpacing(2)
                    .multilineTextAlignment(.leading)
                    .font(.custom(FontsManager.fontRegular, size: 14))
                    
            }.padding(.vertical, 18).padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color("FFFAE6", bundle: .module))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .foregroundStyle(Color("Neutral Eight", bundle: .module))
            
            HStack(alignment: .center, spacing: 5){
                Text("Wait time")
                    .font(.custom(FontsManager.fontRegular, size: 12))
                    .foregroundStyle(Color("8C8C8C", bundle: .module))
                Text(printSecondsToHoursMinutesSeconds(timeRemaining))
                    .font(.custom(FontsManager.fontRegular, size: 12)).foregroundStyle(Color("8C8C8C", bundle: .module))
                Image("clock", bundle: .module)
                ProgressView(value: progessAmount, total: progessTotal).frame(width: 80).tint(Color("Button Primary", bundle: .module))
            }.padding(.vertical, 14).frame(maxWidth: .infinity).overlay{
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color("Neutral Two", bundle: .module), lineWidth: 1)
            }
            
            Spacer().frame(height: 6)
            NoBorderButton(buttonText: "Need help with this transaction?", color: Color("AA8800", bundle: .module), action: {
                onHelpAction()
            })
        }.onReceive(timer) { time in
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
                progessAmount += 1
            } else {
                onTimerEndedAction()
                // it's ended
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
    TransferConfirmationView()
}
