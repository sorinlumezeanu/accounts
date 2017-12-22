//
//  AccountDTOProtocol.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

protocol AccountDTOProtocol {
    var id: Int? { get }
    var name: String? { get }
    var number: String? { get }
    
    var balanceInCents: Int? { get }
    var currency: Currency? { get }
}
