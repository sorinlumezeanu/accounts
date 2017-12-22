//
//  AccountType.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

enum AccountType: String, CustomStringConvertible {
    
    case payment = "PAYMENT"
    case savings = "SAVING"
    case creditCard = "CREDITCARD"
    
    static let allValues: [AccountType] = [.payment, .savings, .creditCard]
    
    var description: String {
        get {
            switch self {
            case .payment:
                return "Payment"
            case .savings:
                return "Savings"
            case .creditCard:
                return "Credit Card"
            }
        }
    }
    
    static func failedAccountTypes(fromServerResponseString serverResponseString: String) -> [AccountType]? {
        //  we'd have to know more about how the server response string is structured in order to do some real parsing
        //  the available exmple is quite brief:
        //      failedAccountTypes = “CREDITCARDS";
        
        if serverResponseString.contains("CREDITCARDS") {
            return [.creditCard]
        }
        
        return nil
    }
}
