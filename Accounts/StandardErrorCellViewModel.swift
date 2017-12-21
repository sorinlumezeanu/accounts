//
//  StandardErrorCellViewModel.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

class StandardErrorCellViewModel {
    
    private var error: Error
    
    init(withError error: Error) {
        self.error = error
    }
    
    var errorMessage: String? {
        get {
            return self.error.localizedDescription
        }
    }
}
