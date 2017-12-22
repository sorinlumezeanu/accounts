//
//  AppDelegate.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import UIKit
import WatchConnectivity

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var wcSession: WCSession!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        NSKeyedArchiver.setClassName("AccountDTOResponse", for: AccountDTOResponse.self)
        NSKeyedArchiver.setClassName("AccountDTO", for: AccountDTO.self)
        NSKeyedUnarchiver.setClass(AccountDTOResponse.self, forClassName: "AccountDTOResponse")
        NSKeyedUnarchiver.setClass(AccountDTO.self, forClassName: "AccountDTO")
        
        ServiceProvider.addDefaultResolvers()
        
        if WCSession.isSupported() {
            self.wcSession = WCSession.default()
            self.wcSession.delegate = self
            self.wcSession.activate()
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

extension AppDelegate: WCSessionDelegate {
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        let accountService: AccountServiceProtocol = ServiceProvider.resolve()
        accountService.fetchAccountDTOs(withOptions: .all) { (accountDTOs, error) in
            if let accountDTOs = accountDTOs {
                let response = AccountDTOResponse()
                response.accounts = accountDTOs as? [AccountDTO]
                let responseData = NSKeyedArchiver.archivedData(withRootObject: response)
                replyHandler(["response": responseData])
            }
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
    }
    
}

