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
        dataService.fetchAccounts { [weak self] (response, error) in
            if let error = error {
                completion((accountsByType: nil, error: error))
            } else {
                guard let response = response else {
                    completion((accountsByType: nil, error: .invalidDatasource))
                    return
                }
                
                if let filteredResponse = self?.applyFetchingOptions(fetchingOptions, onFetchAccountsResponse: response) {
                    if let accountsByType = self?.aggregateAccounts(fromFetchAccountsResponse: filteredResponse) {
                        completion((accountsByType: accountsByType, error: nil))
                        return
                    }
                }
                
                completion((accountsByType: nil, error: .invalidDatasource))
            }
        }
    }
    
    private func aggregateAccounts(fromFetchAccountsResponse response: FetchAccountsResponse) -> [AccountType: AccountsResponse]? {
        guard let accounts = response.accounts else { return [:] }

        var aggregatedAccounts: [AccountType: AccountsResponse] = [:]

        let failedAccountTypes = Set<AccountType>(response.failedAccountTypes ?? [])
        var accountTypes = Set<AccountType>(accounts.filter { $0.type != nil }.map { $0.type! })
        accountTypes = accountTypes.union(failedAccountTypes)
        
        for accountType in accountTypes {
            if failedAccountTypes.contains(accountType) {
                aggregatedAccounts[accountType] = (accounts: nil, error: ApplicationError.failedAccountType(accountType: accountType))
            } else {
                let accountsForThisType = accounts.filter { $0.type == accountType }
                aggregatedAccounts[accountType] = (accounts: accountsForThisType, error: nil)
            }
        }
        
        return aggregatedAccounts
    }
    
    private func applyFetchingOptions(_ fetchingOptions: AccountFetchingOptions,
                                      onFetchAccountsResponse response: FetchAccountsResponse) -> FetchAccountsResponse {
        guard fetchingOptions == .onlyVisible else { return response }
        
        if let allAccounts = response.accounts {
            response.accounts = allAccounts.filter { $0.isVisible == true }
        }
        
        return response
    }
}
