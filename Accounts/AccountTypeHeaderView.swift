//
//  AccountTypeHeaderView.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import UIKit

class AccountTypeHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = "AccountTypeHeaderViewReuseIdentifier"
    static let nib = UINib(nibName: "AccountTypeHeaderView", bundle: nil)
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var accountTypeLabel: UILabel!
    
    private var viewModel: AccountTypeHeaderViewModel!
    
    func configure(with viewModel: AccountTypeHeaderViewModel) {
        self.viewModel = viewModel
        
        self.accountTypeLabel.text = self.viewModel.accountTypeDisplayText
    }
    
    override func prepareForReuse() {
        self.viewModel = nil
        
        self.accountTypeLabel.text = nil
    }
    
}
