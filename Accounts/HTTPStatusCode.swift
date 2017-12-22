//
//  HTTPStatusCode.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

enum HTTPStatusCode: Int, CustomStringConvertible {
    
    // 2xx success
    case ok = 200
    
    // 4xx client errors
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    
    // etc.
    
    var description: String {
        get {
            switch self {
            case .ok:
                return "\(self.rawValue) OK"
            case .badRequest:
                return "\(self.rawValue) Bad Request"
            case .unauthorized:
                return "\(self.rawValue) Unauthorized"
            case .paymentRequired:
                return "\(self.rawValue) Payment Required"
            case .forbidden:
                return "\(self.rawValue) Forbidden"
            case .notFound:
                return "\(self.rawValue) Not Found"
            }
        }
    }
    
    static func make(fromServerReturnCode serverReturnCode: String) -> HTTPStatusCode? {
        switch serverReturnCode {
        case "OK":
            return .ok
            
            // etc.
            
        default:
            return nil
        }
    }
}
