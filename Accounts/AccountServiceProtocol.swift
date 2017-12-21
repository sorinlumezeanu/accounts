//
//  AccountServiceProtocol.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

protocol AccountServiceProtocol: Service {
    func fetchAccounts(withOptions fetchingOptions: AccountFetchingOptions, completion: @escaping (_ accounts: [Account]?, _ error: Error?) -> Void)
}
