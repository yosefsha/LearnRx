//
//  protocols.swift
//  LearnRx
//
//  Created by Yosef Shachnovsky on 14/01/2020.
//  Copyright © 2020 Yosef Shachnovsky. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MostSimpleQueue {

private var _executingOperationsPublish = PublishRelay<MyOperation>()
    
var pendingOperations = Dictionary<String, MyOperation>()
    var executingOperations = Dictionary<String, MyOperation>() {
        didSet {
            if let op  = executingOperations.values.first {
                _executingOperationsPublish.accept(op)
            }
        }
    }

}
    
struct MyOperation {
    var name:String = "just_a_demo_property"
    
    public var progress: Observable<ProgressInfo> {
        return self._progress.asObservable()
    }
    
    var _progress = PublishSubject<ProgressInfo>()

    var _responseBehaviour: BehaviorSubject<CommunicationResponseProtocol>

    init(responseBehaviour:BehaviorSubject<CommunicationResponseProtocol>) {
        _responseBehaviour = responseBehaviour
    }
}


public protocol CommunicationResponseProtocol {
    
    var data: Data { get }
    var info: RequestInfo { get }

    func cancel()
    
}


struct BLEResponseType: CommunicationResponseProtocol {
    
    var data: Data
    var info: RequestInfo
    
    func cancel() {
        
    }
}


public struct RequestInfo {
    public var progress: ProgressInfo
    public var status: RequestStatus
    public var path: String
    
    public init(progress: ProgressInfo = ProgressInfo() ,status: RequestStatus = .pending, path: String = "") {
        self.progress = progress
        self.status = status
        self.path = path
    }

}

extension String: Error {}

public struct ProgressInfo {
    var identifier: String
    var currentProgress: UInt32
    var totalExpected: UInt32
    var ETA: TimeInterval
    
    public init(identifier: String = "", currentProgress: UInt32 = 0, totalExpected: UInt32 = UINT32_MAX) {
        self.identifier = identifier
        self.currentProgress = currentProgress
        self.totalExpected = totalExpected
        self.ETA = TimeInterval(Double((totalExpected - currentProgress)/8000))
    }
}

public enum RequestStatus: String, Encodable {
    
    case pending = "pending"
    case executing = "executing"
    case canceled = "canceled"
    case completed = "completed"
    
}


public struct ProgressSource {
    
    public var progressObservable: Observable<ProgressInfo> {
        return _progressObservable.asObservable()
    }
    var _progressObservable = PublishSubject<ProgressInfo>()

}
