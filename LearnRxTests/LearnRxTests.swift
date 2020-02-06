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
    
    var op:MyOperation?
    
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
        

        createOp().subscribe(onNext:{ args in
                print("receivec data: \(args.data.count)")
        }, onCompleted: {
            print("completed!!!")
            completeExp.fulfill()
        }).disposed(by: disposebag)
        
        let progressSource = ProgressSource()
        guard let op = op else {
            XCTFail("no op!!!!")
            return
        }
        
        op.progress.subscribe(onNext: { p in
            print("received progress: \(p)")
            }, onCompleted: { print("progress completed")}).disposed(by: disposebag)
        
        
        progressSource.progressObservable.bind(to: op._progress).disposed(by: disposebag)
        
        progressSource._progressObservable.onNext(ProgressInfo(identifier: "aaa", currentProgress: 30, totalExpected: 60))
        progressSource._progressObservable.onNext(ProgressInfo(identifier: "aaa", currentProgress: 40, totalExpected: 60))
        progressSource._progressObservable.onNext(ProgressInfo(identifier: "aaa", currentProgress: 40, totalExpected: 60))
        progressSource._progressObservable.onNext(ProgressInfo(identifier: "aaa", currentProgress: 40, totalExpected: 60))

        
        
        op._progress.onCompleted()
        
        progressSource._progressObservable.onNext(ProgressInfo(identifier: "aaa", currentProgress: 50, totalExpected: 60))

        
//        op._responseBehaviour.onNext(BLEResponseType(data: Data(count: 20), info: RequestInfo()))
//        op._responseBehaviour.onNext(BLEResponseType(data: Data(count: 30), info: RequestInfo()))
        op._responseBehaviour.onCompleted()
        
        wait(for: [completeExp], timeout: 20)
    }
        

    
    func testScan() {
        
        let completeExp = expectation(description: "com")
        

        createOp().subscribe(onNext:{ args in
                print("receivec data: \(args.data.count)")
        }, onCompleted: {
            print("completed!!!")
            completeExp.fulfill()
        }).disposed(by: disposebag)
        
        let progressSource = ProgressSource()
        guard let op = op else {
            XCTFail("no op!!!!")
            return
        }
        
        op.progress.subscribe(onNext: { p in
            print("received progress: \(p)")
            }, onCompleted: { print("progress completed")}).disposed(by: disposebag)
        
        
        op.progress.scan( [ProgressInfo](), accumulator: { values, newVal in
            return Array(values + [newVal]).suffix(2)
        }).filter({ list in
            list.count == 2
        }).map({ list in
            return (list[0], list[1])
        }) .subscribe(onNext:{ values in
                print("values: \(values)")
            }).disposed(by: disposebag)
        
        progressSource.progressObservable.bind(to: op._progress).disposed(by: disposebag)
        progressSource._progressObservable.onNext(ProgressInfo(identifier: "aaa", currentProgress: 30, totalExpected: 600))
        progressSource._progressObservable.onNext(ProgressInfo(identifier: "aaa", currentProgress: 40, totalExpected: 600))
        progressSource._progressObservable.onNext(ProgressInfo(identifier: "aaa", currentProgress: 40, totalExpected: 600))
        progressSource._progressObservable.onNext(ProgressInfo(identifier: "aaa", currentProgress: 50, totalExpected: 600))

        
        
        op._progress.onCompleted()
        
        progressSource._progressObservable.onNext(ProgressInfo(identifier: "aaa", currentProgress: 50, totalExpected: 60))

        
//        op._responseBehaviour.onNext(BLEResponseType(data: Data(count: 20), info: RequestInfo()))
//        op._responseBehaviour.onNext(BLEResponseType(data: Data(count: 30), info: RequestInfo()))
        op._responseBehaviour.onCompleted()
        
        wait(for: [completeExp], timeout: 20)
    }
    
    func testBLEresponse() {
        
        let completeExp = expectation(description: "com")
        

        createOp().subscribe(onNext:{ args in
                print("receivec data: \(args.data.count)")
        }, onCompleted: {
            print("completed!!!")
            completeExp.fulfill()
        }).disposed(by: disposebag)
        
        
        op?._responseBehaviour.onNext(BLEResponseType(data: Data(count: 20), info: RequestInfo()))
        op?._responseBehaviour.onNext(BLEResponseType(data: Data(count: 30), info: RequestInfo()))
        op?._responseBehaviour.onCompleted()
        
        wait(for: [completeExp], timeout: 20)
    }
    
    func createOp() -> Observable<CommunicationResponseProtocol> {
        let resBehaviur: BehaviorSubject<CommunicationResponseProtocol> = BehaviorSubject<CommunicationResponseProtocol>(value:BLEResponseType(data: Data(), info: RequestInfo()))

        op = MyOperation(responseBehaviour: resBehaviur)
        
        return resBehaviur.asObservable()
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

struct  ProgressValues {
    var prev: ProgressInfo?
    var last: ProgressInfo?
}

extension String: Error {}
