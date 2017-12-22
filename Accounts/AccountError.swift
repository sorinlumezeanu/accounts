//
//  AccountError.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

enum AccountError: Error, CustomStringConvertible {
    case datasourceNotFound
    case invalidDatasourceResponse
    case unknown
    
    var description: String {
        get {
            switch self {
            case .datasourceNotFound:
                return "Datasource not found."
            case .invalidDatasourceResponse:
                return "Invalid datasource response."
            case .unknown:
                return "Unknown error."
            }
        }
    }
}
