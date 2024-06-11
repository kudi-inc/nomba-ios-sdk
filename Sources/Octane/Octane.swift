// The Swift Programming Language
// https://docs.swift.org/swift-book
#if canImport(UIKit)
import UIKit
#endif

import SwiftUI

public class Octane{
    
    let fontsManager = FontsManager()
    static var clientId = "my-fancy-public-key"
    static var accountId = "my-fancy-widget-key"
    static var clientKey = "my-fancy-widget-key"
    static var colorTheme = ColorTheme.AUTO
    
    public static let shared = Octane()
    
    private init() {}
    
    func registerAllFonts(){
        try! fontsManager.registerFont(named: FontsManager.fontRegular)
        try! fontsManager.registerFont(named: FontsManager.fontBold)
        try! fontsManager.registerFont(named: FontsManager.fontBlack)
        try! fontsManager.registerFont(named: FontsManager.fontMedium)
    }
    
    public func configure(clientId: String, accountId: String, clientKey: String) {
        Octane.clientId = clientId
        Octane.accountId = accountId
        Octane.clientKey = clientKey
        registerAllFonts()
    }
    
    /// (SwiftUI) The Changelog view.
    public var view: some View {
        return PaymentsOptionsView()
            .preferredColorScheme(Octane.colorTheme == .AUTO ? .none : Octane.colorTheme == .LIGHT ? .light : .dark)
    }
    
    #if canImport(UIKit) && !os(visionOS)
    /// (UIKit) The Changelog viewcontroller.
    public var viewController: UIViewController {
        UIHostingController(rootView: PaymentsOptionsView().preferredColorScheme(Octane.colorTheme == .AUTO ? .none : Octane.colorTheme == .LIGHT ? .light : .dark))
    }
    #endif
    
    public func colorTheme(theme: ColorTheme){
        Octane.colorTheme = theme
    }
    
}
