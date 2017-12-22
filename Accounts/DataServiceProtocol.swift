//
//  DataServiceProtocol.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

protocol DataServiceProtocol: Service {
    func fetchAccounts(completion: @escaping (_ accounts: [Account]?, _ error: AccountError?) -> Void)    
}
