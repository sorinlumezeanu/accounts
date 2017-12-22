//
//  AccountsInterfaceController.swift
//  Accounts WatchKit Extension
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation
import WatchKit
import WatchConnectivity

class AccountsInterfaceController: WKInterfaceController {
    
    var wcSession: WCSession!
    
    fileprivate var isWCSessionActivated = false
    fileprivate var shouldFetchAccounts = false

    @IBOutlet var accountsTable: WKInterfaceTable!

    var accounts: [AccountDTOProtocol] = []
    
    override func willActivate() {
        super.willActivate()
        
        self.activateWCSession()
    }
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)

        if self.isWCSessionActivated {
            self.fetchAccounts()
        } else {
            self.shouldFetchAccounts = true
        }
    }
    
    func updateUI() {
        self.accountsTable.setNumberOfRows(accounts.count, withRowType: "AccountRow")
        
        for index in 0 ..< accountsTable.numberOfRows {
            guard let rowController = self.accountsTable.rowController(at: index) as? AccountRowController else { continue }            
            rowController.account = self.accounts[index]
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let account = self.accounts[rowIndex]
        self.presentController(withName: "Account", context: account)
    }
    
    func fetchAccounts() {
        guard let wcSession = self.wcSession else { return }
        
        wcSession.sendMessage([:], replyHandler: { [weak self] (response) in
            if let strongSelf = self {
                let response = NSKeyedUnarchiver.unarchiveObject(with: response["response"] as! Data) as? AccountDTOResponse
                if let receivedAccounts = response?.accounts {
                    strongSelf.accounts = receivedAccounts
                    
                    DispatchQueue.main.async {
                        strongSelf.updateUI()
                    }
                }
            }
        }) { (error) in
            print(error)
        }
    }
    
    
    private func activateWCSession() {
        guard self.isWCSessionActivated == false else { return }
        
        if WCSession.isSupported() {
            self.wcSession = WCSession.default()
            self.wcSession.delegate = self
            self.wcSession.activate()
        }
    }
}

extension AccountsInterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        DispatchQueue.main.async {
            self.isWCSessionActivated = true
            
            if self.shouldFetchAccounts {
                self.fetchAccounts()
            }
        }
    }

}
