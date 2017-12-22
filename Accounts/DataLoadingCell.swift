//
//  DataLoadingCell.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import UIKit

class DataLoadingCell: UITableViewCell {
    
    static let reuseIdentifier = "DataLoadingCellReuseIdentifier"
    static let nib = UINib(nibName: "DataLoadingCell", bundle: nil)
    
    @IBOutlet weak var loadingMessageLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel: DataLoadingCellViewModel!
    
    func configure(with viewModel: DataLoadingCellViewModel) {
        self.viewModel = viewModel
        
        self.loadingMessageLabel.text = self.viewModel.loadingMessage
        self.activityIndicator.startAnimating()
    }
    
    override func prepareForReuse() {
        self.viewModel = nil
        
        self.loadingMessageLabel.text = nil
        self.activityIndicator.stopAnimating()
    }
}
