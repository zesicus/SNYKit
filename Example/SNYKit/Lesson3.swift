//
//  Lesson3.swift
//  SNYKit_Example
//
//  Created by Sunny on 2019/6/2.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

class Lesson3 {
    
    static func start() {
        
        // PublishProject
//        let subject = PublishSubject<String>()
        // 订阅后收到前一次事件
//        let subject = BehaviorSubject<String>(value: "RxSwift step by step")
        // 自带缓冲区（指定 2 次历史事件）
        let subject = ReplaySubject<String>.create(bufferSize: 2)
        
        let sub1 = subject.subscribe(onNext: { (str) in
            dprint("sub1 - \(str)")
        })
        subject.onNext("Hello 0")
        subject.onNext("Hello 1")
        
        sub1.dispose()
        
        let sub2 = subject.subscribe(onNext: { (str) in
            dprint("sub2 - \(str)")
        })
        
        subject.onNext("Hello 2")
        subject.onNext("Hello 3")
        
        sub2.dispose()
    }
    
}
