//
//  Product.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

class Product: CustomStringConvertible {
    var type: ProductType?
    var name: String?
    
    var description: String {
        get {
            return (self.name ?? "") + " / " + (self.type?.description ?? "")
        }
    }
}
