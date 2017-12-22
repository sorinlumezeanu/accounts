//
//  FileDataService.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation
import ObjectMapper

class FileDataService: DataServiceProtocol {
    
    private static let bundledDatasourceFileName = "Datasource"
    
    func fetchAccounts(completion: @escaping (_ response: FetchAccountsResponse?, _ error: ApplicationError?) -> Void) {
        guard let fileContent = self.loadBundledFile() else {
            completion(nil, .datasourceNotFound)
            return
        }
        guard let jsonContent = JSONConverter().json(from: fileContent) else {
            completion(nil, .invalidDatasource)
            return
        }
        guard let fetchAccountsResponse = Mapper<FetchAccountsResponse>().map(JSONString: jsonContent) else {
            completion(nil, .invalidDatasource)
            return
        }
        guard let returnCode = fetchAccountsResponse.returnCode else {
            completion(nil, .invalidDatasource)     // the return code must always be present in the response, regardles of the actual code value
            return
        }
        guard returnCode == .ok else {
            completion(nil, .httpError(httpStatusCode: returnCode))
            return
        }

        completion(fetchAccountsResponse, nil)
    }
    
    private func loadBundledFile() -> String? {
        guard let filePath = Bundle.main.path(forResource: FileDataService.bundledDatasourceFileName, ofType: "txt") else { return nil }
        
        return try? String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
    }
}




