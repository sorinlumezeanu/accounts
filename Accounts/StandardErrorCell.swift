//
//  StandardErrorCell.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import UIKit

class StandardErrorCell: UITableViewCell {
    
    static let reuseIdentifier = "StandardErrorCellReuseIdentifier"
    static let nib = UINib(nibName: "StandardErrorCell", bundle: nil)
    
    @IBOutlet weak var errorLabel: UILabel!
    
    private var viewModel: StandardErrorCellViewModel!
    
    func configure(with viewModel: StandardErrorCellViewModel) {
        self.viewModel = viewModel
        
        self.selectionStyle = .none
        self.errorLabel.text = viewModel.errorMessage
    }
    
    override func prepareForReuse() {
        self.viewModel = nil
        
        self.errorLabel.text = nil
    }
}
