//
//  LearnRxTests.swift
//  LearnRxTests
//
//  Created by Yosef Shachnovsky on 18/07/2019.
//  Copyright © 2019 Yosef Shachnovsky. All rights reserved.
//

import XCTest
import RxSwift

@testable import LearnRx

class LearnRxTests: XCTestCase {
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        var publish:PublishSubject<Int> = PublishSubject<Int>()
        
        publish.on(.next(8))
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
