//
//  AccountDTO.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

class AccountDTO: AccountDTOProtocol {
    
    var type: AccountType?
    
    var id: Int?
    var name: String?
    var alias: String?
    var number: String?
    
    var balanceInCents: Int?
    var currency: Currency?
    
    var iban: String?
    
    var isVisible: Bool?
    
    var product: Product?
    
    var linkedAccountId: Int?
    
    var targetAmountInCents: Int?
    var isSavingsTargetReached: Bool?
}
