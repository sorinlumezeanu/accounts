//
//  AccountService.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

class AccountService: AccountServiceProtocol {
    
    func fetchAccountTypes(completion: @escaping (_ accountTypes: [AccountType]?, _ error: ApplicationError?) -> Void) {
        completion(AccountType.allValues, nil)
    }
    
    func fetchAccounts(withOptions fetchingOptions: AccountFetchingOptions, completion: @escaping (_ response: AccountsByTypeResponse) -> Void) {
        let dataService: DataServiceProtocol = ServiceProvider.resolve()
        dataService.fetchAccounts { (accounts, error) in
            let response: AccountsByTypeResponse = (accountsByType: nil, error: nil)
            completion(response)
        }        
    }
}
