//
//  AccountsDTOResponse.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

class AccountDTOResponse: NSObject, NSCoding {
    
    var accounts: [AccountDTO]?
    
    override init() {
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.accounts = aDecoder.decodeObject(forKey: "accounts") as? [AccountDTO]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.accounts, forKey: "accounts")
    }
}
