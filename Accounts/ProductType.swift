//
//  ProductType.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

enum ProductType: Int, CustomStringConvertible {
    case standardSavings = 1000
    
    // add future product types here
    
    var description: String {
        get {
            return "\(self.rawValue)"
        }
    }
}
