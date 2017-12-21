//
//  AccountTypeHeaderViewModel.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

class AccountTypeHeaderViewModel {
    
    private(set) var accountType: AccountType
    
    init(withAccountType accountType: AccountType) {
        self.accountType = accountType
    }
    
    var accountTypeDisplayText: String {
        get {
            return self.accountType.description + " Accounts"
        }
    }
}
