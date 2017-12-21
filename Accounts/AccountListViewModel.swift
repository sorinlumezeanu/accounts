//
//  AccountListViewModel.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

protocol AccountListViewModelDelegate: AnyObject {
    func didReceiveAccounts(_ accounts: [Account])
    func didReceiveError(_ error: Error)
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
    private var accounts: [Account]?
    
    init(withFilterType filterType: FilterType, delegate: AccountListViewModelDelegate?) {
        self.filterType = filterType
        self.delegate = delegate
    }
    
    func fetchAccounts() {
        let accountService: AccountServiceProtocol = ServiceProvider.resolve()
        let fetchingOptions = self.filterType.toAccountFetchingOptions()
        
        accountService.fetchAccounts(withOptions: fetchingOptions) { [weak self] (accounts, error) in
            if let error = error {
                self?.delegate?.didReceiveError(error)
            } else {
                if let accounts = accounts {
                    self?.accounts = accounts
                    self?.delegate?.didReceiveAccounts(accounts)
                }
            }
        }
    }
    
    func screenTitle() -> String {
        return "Accounts"
    }
    
    func numberOfAccounts() -> Int {
        return self.accounts?.count ?? 0
    }
    
    func account(for indexPath: IndexPath) -> Account? {
        guard let accounts = self.accounts else { return nil }
        guard indexPath.section == 0 else { return nil }
        guard indexPath.row >= 0 && indexPath.row < accounts.count else { return nil }
        
        return accounts[indexPath.row]
    }
}
