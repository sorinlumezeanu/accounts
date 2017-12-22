//
//  DelegateMockBase.swift
//  AccountsTests
//
//  Created by Sorin Lumezeanu on 22/12/2017.
//  Copyright © 2017 Sorin Lumezeanu. All rights reserved.
//

import Foundation
import XCTest

class DelegateMockBase {
    var testExpectation: XCTestExpectation?
    
    init(withTestExpectation testExpectation: XCTestExpectation?) {
        self.testExpectation = testExpectation
    }
}

