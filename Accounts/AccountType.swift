//
//  AccountType.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

enum AccountType: CustomStringConvertible {
    case payment
    case savings
    case creditCard
    
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
}
