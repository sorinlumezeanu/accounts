//
//  AccountListViewController.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import UIKit

class AccountListViewController: UIViewController {
 
    fileprivate struct Constants {
        static let defaultRowHeight: CGFloat = 44
        static let mediumRowHeight: CGFloat = 60
        
        static let showAccountDetailsSegueIdentifier = "ShowAccountDetailsSegueIdentifier"
    }
    
    @IBOutlet weak var accountsTableView: UITableView!
    
    fileprivate var viewModel: AccountListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = AccountListViewModel(withFilterType: .showAll, delegate: self)
        
        self.navigationItem.title = self.viewModel.screenTitle()
        
        self.accountsTableView.register(StandardErrorCell.nib, forCellReuseIdentifier: StandardErrorCell.reuseIdentifier)
        self.accountsTableView.register(DataLoadingCell.nib, forCellReuseIdentifier: DataLoadingCell.reuseIdentifier)
        self.accountsTableView.register(AccountCell.nib, forCellReuseIdentifier: AccountCell.reuseIdentifier)
        self.accountsTableView.register(NoResultsCell.nib, forCellReuseIdentifier: NoResultsCell.reuseIdentifier)
        self.accountsTableView.register(AccountTypeHeaderView.nib, forHeaderFooterViewReuseIdentifier: AccountTypeHeaderView.reuseIdentifier)
        
        self.accountsTableView.dataSource = self
        self.accountsTableView.delegate = self
        
        // prevent empty rows from showing when there's not enought data
        self.accountsTableView.tableFooterView = UIView()
        
        self.viewModel.startFetchingData()
    }
    
    @IBAction func filterValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.viewModel = AccountListViewModel(withFilterType: .showAll, delegate: self)
            self.accountsTableView.reloadData()
            self.viewModel.startFetchingData()
        case 1:
            self.viewModel = AccountListViewModel(withFilterType: .showOnlyVisible, delegate: self)
            self.accountsTableView.reloadData()
            self.viewModel.startFetchingData()
        default:
            break
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.showAccountDetailsSegueIdentifier {
            if let destination = segue.destination as? AccountDetailsViewController, let account = sender as? Account {
                destination.viewModel = AccountDetailsViewModel(withAccount: account, delegate: destination)
            }
        }
    }
}

extension AccountListViewController: AccountListViewModelDelegate {
    
    func didReceiveAccountTypes(_ accountTypes: [AccountType]) {
        DispatchQueue.main.async {
            self.accountsTableView.reloadData()
        }
    }
    
    func fetchAccountTypesDidFinishWithError(_ error: Error?) {
        DispatchQueue.main.async {
            self.accountsTableView.reloadData()
        }
    }
    
    func didReceiveAccounts(_ accountsByType: [AccountType: AccountsResponse]) {
        DispatchQueue.main.async {
            self.accountsTableView.reloadData()
        }
    }
    
    func fetchAccountsDidFinishWithError(_ error: Error?) {
        DispatchQueue.main.async {
            self.accountsTableView.reloadData()
        }
    }

}

extension AccountListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.numberOfAccountTypes()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfRows(forSection: section)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let rowType = self.viewModel.rowType(forIndexPath: indexPath) else { return 0 }
        
        switch rowType {
        case .account(_):
            return Constants.mediumRowHeight
        default:
            return Constants.defaultRowHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let rowType = self.viewModel.rowType(forIndexPath: indexPath) else { return UITableViewCell() }
        
        switch rowType {
        case .loading(let loadingMessage):
            let cell = self.accountsTableView.dequeueReusableCell(withIdentifier: DataLoadingCell.reuseIdentifier) as! DataLoadingCell
            cell.configure(with: DataLoadingCellViewModel(withLoadingMessage: loadingMessage))
            return cell
            
        case .error(let error):
            let cell = self.accountsTableView.dequeueReusableCell(withIdentifier: StandardErrorCell.reuseIdentifier) as! StandardErrorCell
            cell.configure(with: StandardErrorCellViewModel(withError: error))
            return cell
            
        case .noResults(let message):
            let cell = self.accountsTableView.dequeueReusableCell(withIdentifier: NoResultsCell.reuseIdentifier) as! NoResultsCell
            cell.configure(with: NoResultsCellViewModel(withMessage: message))
            return cell

        case .account(let account):
            let cell = self.accountsTableView.dequeueReusableCell(withIdentifier: AccountCell.reuseIdentifier) as! AccountCell
            cell.configure(with: AccountCellViewModel(withAccount: account))
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let _ = self.viewModel.accountType(forSection: section) else { return 0 }
        
        return Constants.defaultRowHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let accountType = self.viewModel.accountType(forSection: section) else { return nil }
        
        let headerView = self.accountsTableView.dequeueReusableHeaderFooterView(withIdentifier: AccountTypeHeaderView.reuseIdentifier) as! AccountTypeHeaderView
        headerView.configure(with: AccountTypeHeaderViewModel(withAccountType: accountType))
        return headerView
    }
    

}

extension AccountListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let rowType = self.viewModel.rowType(forIndexPath: indexPath) else { return }
        
        switch rowType {
        case .account(let account):
            self.performSegue(withIdentifier: Constants.showAccountDetailsSegueIdentifier, sender: account)
        default:
            break
        }
    }
    
}
