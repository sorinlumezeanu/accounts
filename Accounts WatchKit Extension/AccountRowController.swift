//
//  AccountRowController.swift
//  Accounts WatchKit Extension
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import WatchKit

class AccountRowController: NSObject {
    
    @IBOutlet var separator: WKInterfaceSeparator!
    @IBOutlet var accountNumberLabel: WKInterfaceLabel!
    @IBOutlet var accountBalanceLabel: WKInterfaceLabel!
    
    var account: AccountDTOProtocol? {
        didSet {
            guard let account = account else { return }
            
            // account number
            self.accountNumberLabel.setText(account.number ?? "")
            
            // balance
            guard let currency = account.currency else { return }
            guard let balanceInCents = account.balanceInCents else { return }
            let currencyFormatter = currency.formatter(withMaxFractionDigits: 2)
            let balanceText = currencyFormatter.string(from: NSNumber(value: Double(balanceInCents) / 100.0))            
            self.accountBalanceLabel.setText(balanceText)
        }
    }
}
