//
//  AccountDetailsViewModel.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

protocol AccountDetailsViewModelDelegate: AnyObject {
    func didTapOnLinkedAccount(_ linkedAccount: Account)
}

class AccountDetailsViewModel {
    
    weak var delegate: AccountDetailsViewModelDelegate?
    private var account: Account
    
    init(withAccount account: Account, delegate: AccountDetailsViewModelDelegate?) {
        self.account = account
        self.delegate = delegate
    }
    
    var screenTitle: String? {
        get {
            return self.accountNumberText
        }
    }
    
    var accountTypeText: String? {
        get {
            return self.account.type?.description
        }
    }
    
    var accountIdentifierText: String? {
        get {
            guard let accountId = self.account.id else { return nil }
            return "\(accountId)"
        }
    }
    
    var accountNumberText: String? {
        get {
            return self.account.number
        }
    }
    
    var accountNameText: String? {
        get {
            return self.account.name?.trimmingCharacters(in: .punctuationCharacters)
        }
    }
    
    var accountAliasText: String? {
        get {
            return self.account.alias
        }
    }
    
    var accountBalanceText: String? {
        get {
            guard let currency = self.account.currency else { return nil }
            guard let balanceInCents = self.account.balanceInCents else { return nil }
            
            let currencyFormatter = currency.formatter(withMaxFractionDigits: 2)
            return currencyFormatter.string(from: NSNumber(value: Double(balanceInCents) / 100.0))
        }
    }
    
    var ibanText: String? {
        get {
            return self.account.iban
        }
    }
    
    var productText: String? {
        get {            
            return self.account.product?.description
        }
    }
    
    var targetAmountText: String? {
        get {
            guard let currency = self.account.currency else { return nil }
            guard let targetAmountInCents = self.account.targetAmountInCents else { return nil }
            
            let currencyFormatter = currency.formatter(withMaxFractionDigits: 2)
            return currencyFormatter.string(from: NSNumber(value: Double(targetAmountInCents) / 100.0))
        }
    }
    
    var isSavingsTargetReachedText: String? {
        get {
            return self.account.isSavingsTargetReached == true ? "Yes" : "No"
        }
    }
    
    var linkedAccountText: String? {
        get {
            guard let linkedAccountId = self.account.linkedAccountId else { return nil }
            return "\(linkedAccountId)"
        }
    }
    
    var shouldDisplayAccountSavingsDetails: Bool {
        get {
            return self.account.type == AccountType.savings
        }
    }
}
