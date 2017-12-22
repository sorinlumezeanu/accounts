//
//  ApplicationError.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

enum ApplicationError: Error, CustomStringConvertible {
    case datasourceNotFound
    case invalidDatasource
    case httpError(httpStatusCode: HTTPStatusCode)
    case failedAccountType(accountType: AccountType)    
    case unknown
    
    var description: String {
        get {
            switch self {
            case .datasourceNotFound:
                return "Datasource not found."
            case .invalidDatasource:
                return "Invalid datasource."
            case .httpError(let httpStatusCode):
                return "HTTP error: \(httpStatusCode)"
            case .failedAccountType(let accountType):
                return "Failed to retrieve data for account type: \(accountType)"
            case .unknown:
                return "Unknown error."
            }
        }
    }
}
