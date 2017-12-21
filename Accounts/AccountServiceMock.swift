//
//  AccountServiceMock.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

class AccountServiceMock: AccountServiceProtocol {
    
    func fetchAccounts(completion: @escaping (_ accounts: [Account]?, _ error: Error?) -> Void) {
        var accounts = [Account]()
        
        var account = PaymentAccount()
        account.id = 748757694
        account.name = "Hr P L G N StellingTD"
        account.number = "\(748757694)"
        account.balanceInCents = 985000
        account.currency = .EUR
        account.isVisible = true
        account.iban = "NL23INGB0748757694"
        accounts.append(account)
        
        account = PaymentAccount()
        account.id = 700000027559
        account.name = ","
        account.number = "\(748757732)"
        account.balanceInCents = 1000000
        account.currency = .EUR
        account.isVisible = false
        account.iban = "NL88INGB0748757732"
        accounts.append(account)

        let savingsAccount = SavingsAccount()
        savingsAccount.id = 700000027559
        savingsAccount.name = nil
        savingsAccount.number = "H 177-27066"
        savingsAccount.alias = "G\\UfffdLSAVINGSdiacrits"
        savingsAccount.balanceInCents = 15000
        savingsAccount.currency = .EUR
        savingsAccount.isVisible = true
        savingsAccount.iban = nil
        savingsAccount.isSavingsTargetReached = true
        savingsAccount.targetAmountInCents = 2000
        savingsAccount.product = Product()
        savingsAccount.product?.type = .standardSavings
        savingsAccount.product?.name = "Oranje Spaarrekening"
        accounts.append(savingsAccount)

        DispatchQueue.global(qos: .userInitiated).async {
            completion(accounts, nil)
        }        
    }
}
