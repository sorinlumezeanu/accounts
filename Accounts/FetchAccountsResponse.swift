//
//  FetchAccountsResponse.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

import ObjectMapper

class FetchAccountsResponse: Mappable {
    
    var accounts: [Account]?
    var failedAccountTypes: [AccountType]?
    var returnCode: HTTPStatusCode?
    
    public required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        // accounts
        self.accounts <- map["accounts"]
        
        // failed account types
        var failedAccountTypesString: String?
        failedAccountTypesString <- map["failedAccountTypes"]
        if let failedAccountTypesString = failedAccountTypesString {
            self.failedAccountTypes = AccountType.failedAccountTypes(fromServerResponseString: failedAccountTypesString)
        }
        
        // server return code (interprete as standard HTTP status code)
        var returnCodeString: String?
        returnCodeString <- map["returnCode"]
        if let returnCodeString = returnCodeString {
            self.returnCode = HTTPStatusCode.make(fromServerReturnCode: returnCodeString)
        }
    }
}
