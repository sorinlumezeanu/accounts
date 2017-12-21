//
//  AccountServiceProtocol.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

typealias AccountsResponse = (accounts: [Account]?, error: AccountError?)
typealias AccountsByTypeResponse = (accountsByType: [AccountType: AccountsResponse]?, error: AccountError?)

protocol AccountServiceProtocol: Service {
    func fetchAccountTypes(completion: @escaping (_ accountTypes: [AccountType]?, _ error: AccountError?) -> Void)
    func fetchAccounts(withOptions fetchingOptions: AccountFetchingOptions, completion: @escaping (_ response: AccountsByTypeResponse) -> Void)
}
