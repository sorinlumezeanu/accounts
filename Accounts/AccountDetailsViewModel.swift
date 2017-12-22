//
//  AccountDetailsViewModel.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

protocol AccountDetailsViewModelDelegate: AnyObject {
    func didTapOnLinkedAccount(_ linkedAccount: Account)
}

class AccountDetailsViewModel {
    
    weak var delegate: AccountDetailsViewModelDelegate?
    private var account: Account
    
    init(withAccount account: Account, delegate: AccountDetailsViewModelDelegate?) {
        self.account = account
        self.delegate = delegate
    }
    
    var screenTitle: String {
        get {
            return "title here"
        }
    }
}
