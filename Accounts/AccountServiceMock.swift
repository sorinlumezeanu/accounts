//
//  AccountServiceMock.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

class AccountServiceMock: AccountServiceProtocol {
    
    func fetchAccountTypes(completion: @escaping (_ accountTypes: [AccountType]?, _ error: ApplicationError?) -> Void) {
        completion(AccountType.allValues, nil)
    }
    
    func fetchAccounts(withOptions fetchingOptions: AccountFetchingOptions, completion: @escaping (_ response: AccountsByTypeResponse) -> Void) {
        
        var accountsByType = [AccountType: AccountsResponse]()
        
        var paymentAccounts = [Account]()
        
        var paymentAccount = Account()
        paymentAccount.type = .payment
        paymentAccount.id = 748757694
        paymentAccount.name = "Hr P L G N StellingTD"
        paymentAccount.number = "\(748757694)"
        paymentAccount.balanceInCents = 985000
        paymentAccount.currency = .EUR
        paymentAccount.isVisible = true
        paymentAccount.iban = "NL23INGB0748757694"
        paymentAccounts.append(paymentAccount)
        
        paymentAccount = Account()
        paymentAccount.type = .payment
        paymentAccount.id = 700000027559
        paymentAccount.name = ","
        paymentAccount.number = "\(748757732)"
        paymentAccount.balanceInCents = 1000000
        paymentAccount.currency = .EUR
        paymentAccount.isVisible = false
        paymentAccount.iban = "NL88INGB0748757732"
        paymentAccounts.append(paymentAccount)
        
        let filteredPaymentAccounts = (fetchingOptions == .onlyVisible)
            ? paymentAccounts.filter { $0.isVisible == true }
            : paymentAccounts
        accountsByType[.payment] = AccountsResponse(accounts: filteredPaymentAccounts, error: nil)

        let savingsAccount = Account()
        savingsAccount.type = .savings
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
        savingsAccount.linkedAccount = paymentAccounts.first { $0.id == 748757694 }
        
        let savingsAccounts: [Account] = [savingsAccount]
        let filteredSavingsAccount = (fetchingOptions == .onlyVisible)
            ? savingsAccounts.filter { $0.isVisible == true }
            : savingsAccounts
        accountsByType[.savings] = AccountsResponse(accounts: filteredSavingsAccount, error: nil)
        
        
        accountsByType[.creditCard] = AccountsResponse(accounts: nil, error: ApplicationError.unknown)
        
        completion(AccountsByTypeResponse(accountsByType: accountsByType, error: nil))
    }
}
