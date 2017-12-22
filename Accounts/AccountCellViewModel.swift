//
//  AccountCellViewModel.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

class AccountCellViewModel {

    private var account: Account
    
    init(withAccount account: Account) {
        self.account = account
    }
    
    var accountNumberDisplayText: String? {
        get {
            guard let accountNumber = self.account.number else { return nil }
            return accountNumber
        }
    }
    
    var accountBalanceDisplayText: String? {
        get {
            guard let currency = self.account.currency else { return nil }
            guard let balanceInCents = self.account.balanceInCents else { return nil }
            
            let currencyFormatter = currency.formatter(withMaxFractionDigits: 2)
            return currencyFormatter.string(from: NSNumber(value: Double(balanceInCents) / 100.0))
        }
    }
}
