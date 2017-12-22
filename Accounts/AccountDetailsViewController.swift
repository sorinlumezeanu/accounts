//
//  AccountDetailsViewController.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import UIKit

class AccountDetailsViewController: UIViewController {
    
    @IBOutlet weak var accountTypeLabel: UILabel!
    @IBOutlet weak var accountIdentifierLabel: UILabel!
    @IBOutlet weak var accouontNumberLabel: UILabel!
    @IBOutlet weak var accountNameLabel: UILabel!
    @IBOutlet weak var accountAliasLabel: UILabel!
    @IBOutlet weak var accountIbanLabel: UILabel!
    @IBOutlet weak var accountBalanceLabel: UILabel!
    
    @IBOutlet weak var productCaptionLabel: UILabel!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var targetAmountCaptionLabel: UILabel!
    @IBOutlet weak var targetAmountLabel: UILabel!
    @IBOutlet weak var isSavingsTargetReachedCaptionLabel: UILabel!
    @IBOutlet weak var isSavingsTargetReachedLabel: UILabel!
    
    @IBOutlet weak var linkedAccountCaptionLabel: UILabel!
    @IBOutlet weak var linkedAccountButton: UIButton!
    
    @IBAction func didTapOnLinkedAccountButton(_ sender: UIButton) {
    }

    
    var viewModel: AccountDetailsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = self.viewModel.screenTitle
        self.updateAccountDetails()
    }
    
    private func updateAccountDetails() {
        self.accountTypeLabel.text = self.viewModel.accountTypeText
        self.accountIdentifierLabel.text = self.viewModel.accountIdentifierText
        self.accouontNumberLabel.text = self.viewModel.accountNumberText
        self.accountNameLabel.text = self.viewModel.accountNameText
        self.accountAliasLabel.text = self.viewModel.accountAliasText
        self.accountIbanLabel.text = self.viewModel.ibanText
        self.accountBalanceLabel.text = self.viewModel.accountBalanceText
        
        if self.viewModel.shouldDisplayAccountSavingsDetails {
            self.productLabel.text = self.viewModel.productText
            self.targetAmountLabel.text = self.viewModel.targetAmountText
            self.isSavingsTargetReachedLabel.text = self.viewModel.isSavingsTargetReachedText
            self.linkedAccountButton.setTitle(self.viewModel.linkedAccountText, for: .normal)
        } else {
            self.productLabel.isHidden = true
            self.productCaptionLabel.isHidden = true
            self.targetAmountLabel.isHidden = true
            self.targetAmountCaptionLabel.isHidden = true
            self.isSavingsTargetReachedLabel.isHidden = true
            self.isSavingsTargetReachedCaptionLabel.isHidden = true
            self.linkedAccountButton.isHidden = true
            self.linkedAccountCaptionLabel.isHidden = true
        }
    }
}

extension AccountDetailsViewController: AccountDetailsViewModelDelegate {
    
    func didTapOnLinkedAccount(_ linkedAccount: Account) {
    }
}
