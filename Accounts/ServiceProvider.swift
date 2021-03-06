//
//  ServiceProvider.swift
//  Accounts
//
//  Created by Sorin Lumezeanu on 21/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation

public final class ServiceProvider {
    
    struct ResolverKey: Hashable, Equatable {
        var protocolType: Any.Type
        
        var hashValue: Int {
            return "\(protocolType)".hashValue
        }
        
        static func ==(lhs: ResolverKey, rhs: ResolverKey) -> Bool {
            return lhs.protocolType == rhs.protocolType
        }
    }
    
    private static var resolvers = [ResolverKey : () -> Any]()
    
    public static func register<T>(resolver: @escaping () -> T) {
        ServiceProvider.resolvers[ResolverKey(protocolType: T.self)] = resolver
    }
    
    public static func resolve<T>() -> T {
        let key = ResolverKey(protocolType: T.self)
        guard let resolver = self.resolvers[key] else {
            fatalError("Unregistered service type: \(T.self)")
        }
        return resolver() as! T
    }
    
    static func addDefaultResolvers() {
        ServiceProvider.clearResolvers()
        
        ServiceProvider.register { FileDataService() as DataServiceProtocol }
        ServiceProvider.register { AccountService() as AccountServiceProtocol }
    }
    
    public static func clearResolvers() {
        ServiceProvider.resolvers.removeAll()
    }
}
