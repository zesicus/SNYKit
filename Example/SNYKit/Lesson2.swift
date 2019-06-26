//
//  Lesson2.swift
//  SNYKit_Example
//
//  Created by Sunny on 2019/6/2.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

class Lesson2 {
    
    static func start() {
        // Observable create
        let customOb = Observable<Int>.create { (observable) -> Disposable in
            // event
            observable.onNext(10)
            observable.onNext(11)
            // on complete
            observable.onCompleted()
            
            return Disposables.create()
        }
        
        customOb
            //调试
            .debug()
            //订阅
            .subscribe(onNext: { (num) in
                dprint(num)
            }, onCompleted: {
                dprint("运行结束")
            }).dispose()
    }
    
}
