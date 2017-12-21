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
    
    weak var delegate: AccountListViewModelDelegate?
    
    private let filterType: FilterType
    
    private var accountTypes: [AccountType]?
    private var accountsByType: [AccountType: AccountsResponse]?
    
    init(withFilterType filterType: FilterType, delegate: AccountListViewModelDelegate?) {
        self.filterType = filterType
        self.delegate = delegate
    }
    
    func fetchAccountTypes() {
        let accountService: AccountServiceProtocol = ServiceProvider.resolve()

        accountService.fetchAccountTypes { [weak self] (accountTypes, error) in
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
        let accountService: AccountServiceProtocol = ServiceProvider.resolve()
        let fetchingOptions = self.filterType.toAccountFetchingOptions()
        
        accountService.fetchAccounts(withOptions: fetchingOptions) { [weak self] (accountsByTypeResponse) in
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
    
    func numberOfSections() -> Int {
        return self.accountTypes?.count ?? 0
    }
    
    func numberOfRows(forSection section: Int) -> Int {
        guard let accountsByType = self.accountsByType else { return 0 }
        guard let accountType = AccountType(rawValue: section) else { return 0 }
        guard let accountsResponseForGivenType = accountsByType[accountType] else { return 0 }
        
        if let accountsForGivenType = accountsResponseForGivenType.accounts {
            return accountsForGivenType.count > 0
                ? accountsForGivenType.count    // 1 row per Account
                : 1                             // row saying "there are no accounts of this type"
        } else {
            return 1    // row saying "there was an error fetching Accounts of this type"
        }
    }
    
    func account(for indexPath: IndexPath) -> Account? {
        guard let accountsByType = self.accountsByType else { return nil }
        guard let accountType = AccountType(rawValue: indexPath.section) else { return nil }
        guard let accountsResponseForGivenType = accountsByType[accountType] else { return nil }
        guard let accountsForGivenType = accountsResponseForGivenType.accounts else { return nil }
        guard indexPath.row >= 0 && indexPath.row < accountsForGivenType.count else { return nil }

        return accountsForGivenType[indexPath.row]
    }
}
