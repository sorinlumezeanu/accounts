//
//  AccountCell.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {
    
    static let reuseIdentifier = "AccountCellReuseIdentifier"
    static let nib = UINib(nibName: "AccountCell", bundle: nil)
    
    @IBOutlet weak var accountNumberLabel: UILabel!
    @IBOutlet weak var accountBalanceLabel: UILabel!
    
    private var viewModel: AccountCellViewModel!
    
    func configure(with viewModel: AccountCellViewModel) {
        self.viewModel = viewModel
        
        self.selectionStyle = .none
        self.accountNumberLabel.text = self.viewModel.accountNumberDisplayText
        self.accountBalanceLabel.text = self.viewModel.accountBalanceDisplayText
    }
    
    override func prepareForReuse() {
        self.viewModel = nil
        
        self.accountNumberLabel.text = nil
        self.accountBalanceLabel.text = nil
    }
}
