//
//  NombaManager.swift
//  Octane
//
//  Created by Bezaleel Ashefor on 20/05/2024.
//

import Foundation

public final class NombaManager {
    
    static let shared = NombaManager()
    static var paymentAmount : Double = 0.0
    static var orderReference : String = UUID().uuidString
    static var displayViewState : DisplayViewState = DisplayViewState.PAYMENTOPTIONS
    static var customerEmail : String = "customer-email@gmail.com"
    static var customerId : String = UUID().uuidString
    static var customerName : String = "Dumebi Ronaldo"
    
    
    private init(){
        
    }
    
    func showPaymentView(){
        
    }
    
}
