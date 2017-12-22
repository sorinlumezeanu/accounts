//
//  AccountDetailsViewController.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import UIKit

class AccountDetailsViewController: UIViewController {
    
    var viewModel: AccountDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.viewModel.screenTitle
    }
}

extension AccountDetailsViewController: AccountDetailsViewModelDelegate {
    
    func didTapOnLinkedAccount(_ linkedAccount: Account) {
    }
}
