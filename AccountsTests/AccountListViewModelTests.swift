//
//  AccountListViewModelTests.swift
//  AccountsTests
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import XCTest

class AccountListViewModelTests: XCTestCase {
    
    // system under test
    var accountsListViewModel: AccountListViewModel!
    
    override func setUp() {
        super.setUp()
        
        ServiceProvider.register { AccountServiceMock() as AccountServiceProtocol }
    }
    
    override func tearDown() {
        super.tearDown()
        
        ServiceProvider.clearResolvers()
        self.accountsListViewModel = nil
    }
    
    func testFetchAccountTypes() {
        
        class AccountListViewModelDelegateMock: DelegateMockBase, AccountListViewModelDelegate {
            
            func didReceiveAccountTypes(_ accountTypes: [AccountType]) {
                if accountTypes.count == 3 {
                    self.testExpectation?.fulfill()
                } else {
                    XCTFail("Expected 3 account types but received \(accountTypes.count).")
                }
            }
            
            func fetchAccountTypesDidFinishWithError(_ error: Error?) {
                XCTFail("Did not expect 'didReceiveError:_' to be called.")
            }
            
            func didReceiveAccounts(_ accountsByType: [AccountType: AccountsResponse]) {
            }
            
            func fetchAccountsDidFinishWithError(_ error: Error?) {
                XCTFail("Did not expect 'didReceiveError:_' to be called.")
            }
        }
        
        let accountTypesAreReceived = expectation(description: "received 3 account types")
        let mockDelegate = AccountListViewModelDelegateMock(withTestExpectation: accountTypesAreReceived)
        self.accountsListViewModel = AccountListViewModel(withFilterType: .showAll, delegate: mockDelegate)
        
        self.accountsListViewModel.fetchAccountTypes()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    

    func testFetchAccounts() {
        
        class AccountListViewModelDelegateMock: DelegateMockBase, AccountListViewModelDelegate {
            
            func didReceiveAccountTypes(_ accountTypes: [AccountType]) {
            }
            
            func fetchAccountTypesDidFinishWithError(_ error: Error?) {
                XCTFail("Did not expect 'didReceiveError:_' to be called.")
            }
            
            func didReceiveAccounts(_ accountsByType: [AccountType: AccountsResponse]) {
                
                // expect 2 PAYMENT accounts
                guard let paymentAccountsResponse = accountsByType[.payment] else {
                    XCTFail("Expected 2 PAYMENT accounts but received 'nil'.")
                    return
                }
                XCTAssert(paymentAccountsResponse.accounts?.count == 2,
                          "Expected 2 PAYMENT accounts but received \(String(describing: paymentAccountsResponse.accounts?.count)).")
                XCTAssert(paymentAccountsResponse.error == nil,
                          "Did not expect failed PAYMENT accounts")
                
                // expect 1 SAVINGS account
                guard let savingsAccountsResponse = accountsByType[.savings] else {
                    XCTFail("Expected 1 SAVINGS account but received 'nil'.")
                    return
                }
                XCTAssert(savingsAccountsResponse.accounts?.count == 1,
                          "Expected 1 SAVINGS account but received \(String(describing: savingsAccountsResponse.accounts?.count)).")
                XCTAssert(savingsAccountsResponse.error == nil,
                          "Did not expect failed SAVINGS accounts")
                
                // expect failed CREDITCARD accounts
                guard let creditCardAccountsResponse = accountsByType[.creditCard] else {
                    XCTFail("Expected credit-card account response but received 'nil'.")
                    return
                }
                XCTAssert(creditCardAccountsResponse.accounts == nil,
                          "Expected failed CREDITCARD accounts but received \(String(describing: creditCardAccountsResponse.accounts?.count)).")
                XCTAssert(creditCardAccountsResponse.error != nil,
                          "Expected failed CREDITCARD accounts")

                self.testExpectation?.fulfill()
            }
            
            func fetchAccountsDidFinishWithError(_ error: Error?) {
                XCTFail("Did not expect 'didReceiveError:_' to be called.")
            }
        }
        
        let accountsAreReceived = expectation(description: "received correctly received")
        let mockDelegate = AccountListViewModelDelegateMock(withTestExpectation: accountsAreReceived)
        self.accountsListViewModel = AccountListViewModel(withFilterType: .showAll, delegate: mockDelegate)
        
        self.accountsListViewModel.fetchAccounts()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
}

extension AccountListViewModelTests {
    
    class AccountServiceMock: AccountServiceProtocol {
        func fetchAccountDTOs(withOptions fetchingOptions: AccountFetchingOptions, completion: @escaping ([AccountDTOProtocol]?, Error?) -> Void) {
        }
        
        func fetchAccountTypes(completion: @escaping (_ accountTypes: [AccountType]?, _ error: ApplicationError?) -> Void) {
            completion(AccountType.allValues, nil)
        }
        
        func fetchAccounts(withOptions fetchingOptions: AccountFetchingOptions, completion: @escaping (_ response: AccountsByTypeResponse) -> Void) {
            
            var accountsByType = [AccountType: AccountsResponse]()
            
            var paymentAccounts = [Account]()
            
            var paymentAccount = Account()
            paymentAccount.type = .payment
            paymentAccount.id = 748757694
            paymentAccount.name = "Hr P L G N StellingTD"
            paymentAccount.number = "\(748757694)"
            paymentAccount.balanceInCents = 985000
            paymentAccount.currency = .EUR
            paymentAccount.isVisible = true
            paymentAccount.iban = "NL23INGB0748757694"
            paymentAccounts.append(paymentAccount)
            
            paymentAccount = Account()
            paymentAccount.type = .payment
            paymentAccount.id = 700000027559
            paymentAccount.name = ","
            paymentAccount.number = "\(748757732)"
            paymentAccount.balanceInCents = 1000000
            paymentAccount.currency = .EUR
            paymentAccount.isVisible = false
            paymentAccount.iban = "NL88INGB0748757732"
            paymentAccounts.append(paymentAccount)
            
            let filteredPaymentAccounts = (fetchingOptions == .onlyVisible)
                ? paymentAccounts.filter { $0.isVisible == true }
                : paymentAccounts
            accountsByType[.payment] = AccountsResponse(accounts: filteredPaymentAccounts, error: nil)
            
            let savingsAccount = Account()
            savingsAccount.type = .savings
            savingsAccount.id = 700000027559
            savingsAccount.name = nil
            savingsAccount.number = "H 177-27066"
            savingsAccount.alias = "G\\UfffdLSAVINGSdiacrits"
            savingsAccount.balanceInCents = 15000
            savingsAccount.currency = .EUR
            savingsAccount.isVisible = true
            savingsAccount.iban = nil
            savingsAccount.isSavingsTargetReached = true
            savingsAccount.targetAmountInCents = 2000
            savingsAccount.product = Product()
            savingsAccount.product?.type = .standardSavings
            savingsAccount.product?.name = "Oranje Spaarrekening"
            savingsAccount.linkedAccount = paymentAccounts.first { $0.id == 748757694 }
            
            let savingsAccounts: [Account] = [savingsAccount]
            let filteredSavingsAccount = (fetchingOptions == .onlyVisible)
                ? savingsAccounts.filter { $0.isVisible == true }
                : savingsAccounts
            accountsByType[.savings] = AccountsResponse(accounts: filteredSavingsAccount, error: nil)
            
            
            accountsByType[.creditCard] = AccountsResponse(accounts: nil, error: ApplicationError.unknown)
            
            completion(AccountsByTypeResponse(accountsByType: accountsByType, error: nil))
        }
    }
    
    func fetchAccountDTOs(withOptions fetchingOptions: AccountFetchingOptions, completion: @escaping (_ accounts: [AccountDTOProtocol]?, _ error: Error?) -> Void) {
        
    }

}
