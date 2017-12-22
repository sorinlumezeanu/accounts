//
//  Account.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

import ObjectMapper


class Account: AccountDTOProtocol, Mappable {
    
    var type: AccountType?
    
    var id: Int?
    var name: String?
    var alias: String?
    var number: String?
    
    var balanceInCents: Int?
    var currency: Currency?
    
    var iban: String?
    
    var isVisible: Bool?
    
    var product: Product?
    
    var linkedAccountId: Int?
    var linkedAccount: Account?
    
    var targetAmountInCents: Int?
    var isSavingsTargetReached: Bool?
    
    public required init?(map: Map) {
    }
    
    init() {
        // required for mocking Account objects (Tests target)
    }
    
    func mapping(map: Map) {
        
        self.type <- (map["accountType"], TransformOf<AccountType, String>(fromJSON: { AccountType(rawValue: $0!) }, toJSON: { $0.map { String($0.rawValue) } }))
        
        self.id <- (map["accountId"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        self.name <- map["accountName"]
        self.alias <- map["alias"]
        self.number <- map["accountNumber"]
        
        self.balanceInCents <- (map["accountBalanceInCents"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        self.currency <- (map["accountCurrency"], TransformOf<Currency, String>(fromJSON: { Currency(rawValue: $0!) }, toJSON: { $0.map { String($0.rawValue) } }))
        
        self.iban <- map["iban"]
        
        self.isVisible <-  (map["isVisible"], TransformOf<Bool, String>(fromJSON: { Bool($0!) }, toJSON: { $0.map { String($0) } }))
        
        self.isSavingsTargetReached <- (map["savingsTargetReached"], TransformOf<Bool, String>(fromJSON: { Int($0!) == 1 ? true : false }, toJSON: { $0.map { String($0 ? 1 : 0) } }))
        self.targetAmountInCents <- (map["targetAmountInCents"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        
        self.linkedAccountId <- (map["linkedAccountId"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        
        // Product
        var productName: String?
        var productTypeRawValue: Int?
        productName <- map["productName"]
        productTypeRawValue <- (map["productType"], TransformOf<Int, String>(fromJSON: { Int($0!) }, toJSON: { $0.map { String($0) } }))
        if let productTypeRawValue = productTypeRawValue {
            self.product = Product()
            self.product?.name = productName
            self.product?.type = ProductType(rawValue: productTypeRawValue)
        }        
    }
}


