//
//  AccountDTO.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

class AccountDTO: NSObject, AccountDTOProtocol, NSCoding {
    
    var id: Int?
    var name: String?
    var number: String?
    var balanceInCents: Int?
    var currency: Currency?
    
    override init() {        
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.id = aDecoder.decodeObject(forKey: "identifier") as? Int
        self.name = aDecoder.decodeObject(forKey: "name") as? String
        self.number = aDecoder.decodeObject(forKey: "number") as? String
        self.balanceInCents = aDecoder.decodeObject(forKey: "balanceInCents") as? Int
        
        let currencyRawValue = aDecoder.decodeObject(forKey: "currencyRawValue") as? String
        if let currencyRawValue = currencyRawValue {
            self.currency = Currency(rawValue: currencyRawValue)
        }
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(self.id, forKey: "identifier")
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.number, forKey: "number")
        aCoder.encode(self.balanceInCents, forKey: "balanceInCents")
        aCoder.encode(self.currency?.rawValue, forKey: "currencyRawValue")
    }
}


