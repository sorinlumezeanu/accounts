//
//  AccountBase.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

class AccountBase {    
    var id: Int?
    
    var balanceInCents: Int?
    var currency: Currency?
    
    var name: String?
    var alias: String?
    var number: Int?
    
    var iban: String?
    
    var isVisible: Bool?
}
