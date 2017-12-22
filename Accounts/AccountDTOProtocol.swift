//
//  AccountDTOProtocol.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

protocol AccountDTOProtocol {
    var type: AccountType? { get }
    
    var id: Int? { get }
    var name: String? { get }
    var alias: String? { get }
    var number: String? { get }
    
    var balanceInCents: Int? { get }
    var currency: Currency? { get }
    
    var iban: String? { get }
    
    var isVisible: Bool? { get }
    
    var product: Product? { get }
    
    var linkedAccountId: Int? { get }
    
    var targetAmountInCents: Int? { get }
    var isSavingsTargetReached: Bool? { get }
}
