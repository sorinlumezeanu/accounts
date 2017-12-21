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
    
    func identifierDisplayText() -> String? {
        return "\(self.account.id)"
    }
}
