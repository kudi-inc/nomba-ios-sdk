// The Swift Programming Language
// https://docs.swift.org/swift-book
#if canImport(UIKit)
import UIKit
#endif

import SwiftUI

public class Octane{
    
    var  fontsManager: FontsManager?
    static var clientId = "my-fancy-public-key"
    static var accountId = "my-fancy-widget-key"
    static var clientKey = "my-fancy-widget-key"
    static var email = "me@nomba.com"
    static var customer = "Emeka Bond"
    static var amount : Double = 10.00
    static var colorTheme = ColorTheme.LIGHT
    static var errorString = ""
    static var logo :Image?
    static var onTransactionComplete: ((CheckTransactionStatusResponse) -> Void)?
    
    public static let shared = Octane()
    
    private init() {
        fontsManager=FontsManager()
    }
    
    func registerAllFonts(){
        try! fontsManager?.registerFont(named: FontsManager.fontRegular)
        try! fontsManager?.registerFont(named: FontsManager.fontBold)
        try! fontsManager?.registerFont(named: FontsManager.fontBlack)
        try! fontsManager?.registerFont(named: FontsManager.fontMedium)
    }
    
    public func endManager(){
        fontsManager = nil
    }
    
    public func configure(clientId: String, accountId: String, clientKey: String) {
        Octane.clientId = clientId
        Octane.accountId = accountId
        Octane.clientKey = clientKey
        registerAllFonts()
    }
    
    public func setPaymentDetails(email: String, amount: Double, customerName: String, logo:Image?, onTransactionComplete: @escaping (CheckTransactionStatusResponse) -> Void){
        Octane.email = email
        Octane.customer = customerName
        Octane.amount = amount
        Octane.logo = logo
        Octane.onTransactionComplete = onTransactionComplete
    }
    
    func getAmountFormated() -> String {
        return String(format: "%.02f", Octane.amount)
    }
    
    func getAmountFormatedWithCurrency() -> String {
        return String(format: "₦ %.02f", Octane.amount)
    }
    
    
    /// (SwiftUI) The Changelog view.
    public var view: some View {
        return PaymentsOptionsView(logo:Octane.logo, accountId: Octane.accountId, clientId: Octane.clientId, clientKey: Octane.clientKey)
            .preferredColorScheme(Octane.colorTheme == .AUTO ? .none : Octane.colorTheme == .LIGHT ? .light : .dark)
    }
    
    #if canImport(UIKit) && !os(visionOS)
    /// (UIKit) The Changelog viewcontroller.
    public var viewController: UIViewController {
        UIHostingController(rootView: PaymentsOptionsView(logo:Octane.logo, accountId: Octane.accountId, clientId: Octane.clientId, clientKey: Octane.clientKey).preferredColorScheme(Octane.colorTheme == .AUTO ? .none : Octane.colorTheme == .LIGHT ? .light : .dark))
    }
    #endif
    
    public func colorTheme(theme: ColorTheme){
        Octane.colorTheme = theme
    }
    
}
