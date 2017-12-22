//
//  AccountListViewModel.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

protocol AccountListViewModelDelegate: AnyObject {
    
    func didReceiveAccountTypes()
    func fetchAccountTypesDidFinishWithError(_ error: Error?)
    
    func didReceiveAccounts()
    func fetchAccountsDidFinishWithError(_ error: Error?)
}

class AccountListViewModel {
    
    enum FilterType {
        case showAll
        case showOnlyVisible
        
        func toAccountFetchingOptions() -> AccountFetchingOptions {
            switch self {
            case .showAll:
                return .all
            case .showOnlyVisible:
                return .onlyVisible
            }
        }
    }

    enum RowType {
        case loading(message: String)
        case error(error: Error)
        case noResults(message: String)
        case account(account: Account)
    }
    
    weak var delegate: AccountListViewModelDelegate?
    
    private let filterType: FilterType
    
    private var accountTypes: [AccountType]?
    private var accountsByType: [AccountType: AccountsResponse]?
    
    private var isAccountTypesRequestComplete = false
    private var isAccountsRequestComplete = false
    
    init(withFilterType filterType: FilterType, delegate: AccountListViewModelDelegate?) {
        self.filterType = filterType
        self.delegate = delegate
    }
    
    func startFetchingData() {
        self.fetchAccountTypes()
    }
    
    func fetchAccountTypes() {
        self.isAccountTypesRequestComplete = false
        
        let accountService: AccountServiceProtocol = ServiceProvider.resolve()

        accountService.fetchAccountTypes { [weak self] (accountTypes, error) in
            self?.isAccountTypesRequestComplete = true
            self?.accountTypes = accountTypes
            
            if let _ = accountTypes {
                self?.delegate?.didReceiveAccountTypes()
                self?.fetchAccounts()                
            } else {
                self?.delegate?.fetchAccountTypesDidFinishWithError(error)
            }
        }
    }
    
    func fetchAccounts() {
        self.isAccountsRequestComplete = false
        
        let accountService: AccountServiceProtocol = ServiceProvider.resolve()
        let fetchingOptions = self.filterType.toAccountFetchingOptions()
        
        accountService.fetchAccounts(withOptions: fetchingOptions) { [weak self] (accountsByTypeResponse) in
            self?.isAccountsRequestComplete = true
            self?.accountsByType = accountsByTypeResponse.accountsByType
            
            if let _ = accountsByTypeResponse.accountsByType {
                self?.delegate?.didReceiveAccounts()
            } else {
                self?.delegate?.fetchAccountsDidFinishWithError(accountsByTypeResponse.error)
            }
        }
    }
    
    func screenTitle() -> String {
        return "Accounts"
    }
    
    func numberOfAccountTypes() -> Int {
        return self.accountTypes?.count ?? 0
    }
    
    func accountType(forSection section: Int) -> AccountType? {
        guard let accountTypes = self.accountTypes else { return nil }
        guard section >= 0 && section < accountTypes.count else { return nil }
        
        return accountTypes[section]
    }
    
    func numberOfRows(forSection section: Int) -> Int {
        if self.isAccountsRequestComplete == false {
            return 1        // row saying "loading..."
        } else {
            guard let accountType = self.accountType(forSection: section) else { return 0 }
            guard let accountsByType = self.accountsByType else { return 0 }
            guard let accountsResponseForGivenType = accountsByType[accountType] else { return 0 }
            
            if let accountsForGivenType = accountsResponseForGivenType.accounts {
                return accountsForGivenType.count > 0
                    ? accountsForGivenType.count            // 1 row per Account
                    : 1                                     // row saying "there are no accounts of this type"
            } else {
                return 1    // row saying "there was an error fetching Accounts of this type"
            }
        }
    }
    
    
    func rowType(forIndexPath indexPath: IndexPath) -> RowType? {
        if self.isAccountsRequestComplete == false {
            return .loading(message: "Loading...")
        } else {
            guard let accountType = self.accountType(forSection: indexPath.section) else { return nil }
            guard let accountsByType = self.accountsByType else { return nil }
            guard let accountsResponseForGivenType = accountsByType[accountType] else { return nil }

            if let accountsForGivenType = accountsResponseForGivenType.accounts {
                if accountsForGivenType.count > 0 {
                    guard indexPath.row >= 0 && indexPath.row < accountsForGivenType.count else { return nil }
                    
                    return .account(account: accountsForGivenType[indexPath.row])
                } else {
                    return .noResults(message: "There are no accounts for this account type")
                }
            } else {
                if let error = accountsResponseForGivenType.error {
                    return .error(error: error)
                } else {
                    return .error(error: ApplicationError.unknown)
                }
            }
        }
    }
    
    
}
