//
//  PlayWithRx.swift
//  LearnRx
//
//  Created by Yosef Shachnovsky on 02/01/2020.
//  Copyright © 2020 Yosef Shachnovsky. All rights reserved.
//

import Foundation
import RxSwift

class PlayRx {
    func doRxStuff() {
        // Do any additional setup after loading the view.
        print("hello rx")
//        let scheduler = SerialDispatchQueueScheduler(qos: .default)
//        let observable = Observable<Int>.interval(.milliseconds(200), scheduler: scheduler)
//
//        print("type of observable: \(type(of: observable))")
//
//        let subscription = observable
//            .subscribe { event in
//                print("event: \(event)")
//                print("type of event: \(type(of: event))")
//                print("element: \(event.element)")
//                print("event.isCompleted: \(event.isCompleted)")
//                print("event.isStopEvent: \(event.isStopEvent)")
//
//        }
//        print("type of subscription: \(type(of: subscription))")
//
//        Thread.sleep(forTimeInterval: 2.0)
//
//        subscription.dispose()
//
//        Thread.sleep(forTimeInterval: 1.0)
       // let scheduler = SerialDispatchQueueScheduler(qos: .default)
        let observable = Observable<Int>.range(start: 2, count: 10)
        
        print("type of observable: \(type(of: observable))")

        let subscription = observable
            .subscribe { event in
                print("event: \(event)")
                print("type of event: \(type(of: event))")
                print("element: \(event.element)")
                print("event.isCompleted: \(event.isCompleted)")
                print("event.isStopEvent: \(event.isStopEvent)")

        }
        print("type of subscription: \(type(of: subscription))")

        Thread.sleep(forTimeInterval: 2.0)
        
        subscription.dispose()
        
        Thread.sleep(forTimeInterval: 1.0)
    }
}
