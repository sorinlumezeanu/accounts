//
//  AccountType.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

enum AccountType: Int {
    case payment = 0
    case savings
    case creditCard
    
    static let allValues: [AccountType] = [.payment, .savings, .creditCard]
}
