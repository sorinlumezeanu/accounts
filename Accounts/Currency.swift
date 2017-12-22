//
//  Currency.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

enum Currency: String {
    case EUR = "EUR"
    case USD = "USD"
    
    func formatter(withMaxFractionDigits maxFractionDigits: Int) -> NumberFormatter {
        let numberFormatter = NumberFormatter()
        
        numberFormatter.locale = Locale(identifier: "en_GB")
        numberFormatter.numberStyle = NumberFormatter.Style.currency
        numberFormatter.currencyCode = self.rawValue
        numberFormatter.maximumFractionDigits = maxFractionDigits
        
        let locale = NSLocale(localeIdentifier: self.rawValue)
        numberFormatter.currencySymbol = locale.displayName(forKey: NSLocale.Key.currencySymbol, value: self.rawValue)
        
        return numberFormatter
    }
}
