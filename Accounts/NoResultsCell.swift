//
//  NoResultsCell.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import UIKit

class NoResultsCell: UITableViewCell {
    
    static let reuseIdentifier = "NoResultsCellReuseIdentifier"
    static let nib = UINib(nibName: "NoResultsCell", bundle: nil)
    
    @IBOutlet weak var messageLabel: UILabel!
    
    private var viewModel: NoResultsCellViewModel!
    
    func configure(with viewModel: NoResultsCellViewModel) {
        self.viewModel = viewModel
        
        self.selectionStyle = .none
        self.messageLabel.text = self.viewModel.message
    }
    
    override func prepareForReuse() {
        self.viewModel = nil
        
        self.messageLabel.text = nil
    }
}
