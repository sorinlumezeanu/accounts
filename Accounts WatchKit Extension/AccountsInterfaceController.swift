//
//  AccountsInterfaceController.swift
//  Accounts WatchKit Extension
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import WatchKit
import Foundation

class AccountsInterfaceController: WKInterfaceController {
    
    @IBOutlet var accountsTable: WKInterfaceTable!

    var accounts: [AccountDTOProtocol] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        self.accountsTable.setNumberOfRows(accounts.count, withRowType: "AccountRow")
        
        for index in 0 ..< accountsTable.numberOfRows {
            guard let rowController = self.accountsTable.rowController(at: index) as? AccountRowController else { continue }
            
            rowController.account = self.accounts[index]
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let account = self.accounts[rowIndex]
        self.presentController(withName: "Account", context: account)
    }
}
