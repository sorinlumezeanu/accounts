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
            
            self.accountNumberLabel.setText(account.number)
            self.accountBalanceLabel.setText(String(describing: account.balanceInCents))            
        }
    }
}
