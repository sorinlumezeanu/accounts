//
//  StandardErrorCellViewModel.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

class DataLoadingCellViewModel {
    
    private(set) var loadingMessage: String
    
    init(withLoadingMessage loadingMessage: String) {
        self.loadingMessage = loadingMessage
    }
}
