//
//  AccountServiceProtocol.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

typealias AccountsResponse = (accounts: [Account]?, error: Error?)
typealias AccountsByTypeResponse = (accountsByType: [AccountType: AccountsResponse]?, error: Error?)

protocol AccountServiceProtocol: Service {
    func fetchAccountTypes(completion: @escaping (_ accountTypes: [AccountType]?, _ error: Error?) -> Void)
    func fetchAccounts(withOptions fetchingOptions: AccountFetchingOptions, completion: @escaping (_ response: AccountsByTypeResponse) -> Void)
}
