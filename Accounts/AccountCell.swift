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
    
    @IBOutlet weak var accountIdentifierLabel: UILabel!
    
    private var viewModel: AccountCellViewModel!
    
    func configure(with viewModel: AccountCellViewModel) {
        self.viewModel = viewModel
        
        self.accountIdentifierLabel.text = self.viewModel.identifierDisplayText()
    }
    
    override func prepareForReuse() {
        self.viewModel = nil
        
        self.accountIdentifierLabel.text = nil
    }
}
