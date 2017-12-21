//
//  Account.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

protocol Account {
    var type: AccountType { get }

    var balanceInCents: Int? { get set }
    var currency: Currency? { get }
    
    var id: Int? { get }
    var number: String? { get }
    var name: String? { get }
    var alias: String? { get set }
    
    var iban: String? { get }
    
    var isVisible: Bool? { get set }    
}


