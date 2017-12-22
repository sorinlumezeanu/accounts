//
//  FileDataService.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

class FileDataService: DataServiceProtocol {
    
    private static let bundledDatasourceFileName = "Datasource"
    
    func fetchAccounts(completion: @escaping (_ accounts: [Account]?, _ error: AccountError?) -> Void) {
        guard let fileContent = self.loadBundledFile() else {
            completion(nil, .datasourceNotFound)
            return
        }
        
        guard let jsonContent = JSONConverter().json(from: fileContent) else {
            completion(nil, .invalidDatasourceResponse)
            return
        }
        
        // TBD: JSON > object model
        guard let jsonData = jsonContent.data(using: .utf8) else {
            return
        }
        
        guard let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) else {
            return
        }
        
        completion(nil, nil)
    }
    
    private func loadBundledFile() -> String? {
        guard let filePath = Bundle.main.path(forResource: FileDataService.bundledDatasourceFileName, ofType: "txt") else { return nil }
        
        return try? String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
    }
}


