//
//  testCreateDeffered.swift
//  LearnRxTests
//
//  Created by Yosef Shachnovsky on 09/06/2020.
//  Copyright © 2020 Yosef Shachnovsky. All rights reserved.
//

import Foundation

import XCTest
import RxSwift

@testable import LearnRx

class CreateDefferedTests: XCTestCase {
    
    
    var disposebag:DisposeBag!
    override func setUp() {
        disposebag = DisposeBag()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        disposebag = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        let exp = expectation(description: "aaa")
        
        let publish:PublishSubject<Int> = PublishSubject<Int>()
        
        
        publish.asObservable().subscribe(onNext: { data in
            print("received data: \(data)")
        }, onError: { error in
            print("received error: \(error)")
        }, onCompleted: {
            print("completed")
            exp.fulfill()
            }).disposed(by: disposebag)
        
        publish.on(.next(8))
        publish.onCompleted()
        publish.onError("error error")
        
        wait(for: [exp], timeout: 5)
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testBind() {
        
        let completeExp = expectation(description: "com")
        

    
        
        wait(for: [completeExp], timeout: 20)
    }

    
    func createOp() -> Observable<CommunicationResponseProtocol> {
        let resBehaviur: BehaviorSubject<CommunicationResponseProtocol> = BehaviorSubject<CommunicationResponseProtocol>(value:BLEResponseType(data: Data(), info: RequestInfo()))
        
        return resBehaviur.asObservable()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}


