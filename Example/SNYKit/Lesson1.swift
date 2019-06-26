//
//  Lesson1.swift
//  SNYKit_Example
//
//  Created by Sunny on 2019/6/1.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation

class Lesson1 {
    
    static func start() {
        
        // Timer observer
        
        var bag = DisposeBag()
        
        Observable<Int>.interval(RxTimeInterval.seconds(1), scheduler: MainScheduler.asyncInstance).subscribe(onNext: { (value) in
            dprint("定时器执行：\(value)")
        }) {
            dprint("定时器Observer销毁！")
        }.disposed(by: bag)
        
        SNY.gcd.after(time: 5.0, queue: GCD.main) {
            bag = DisposeBag()
        }
        
        // Array observer
        
        let theNums = Observable.from(["1", "2", "3", "4", "5", "6", "7", "8", "9"])
            .map { (numStr) -> Result<Int, SNYError> in
                if let num = Int(numStr) {
                    return .success(num)
                } else {
                    return .failure(.convertFailed)
                }
            }
            .filter { (result) -> Bool in
                switch result {
                case .success(let num):
                    if num % 2 == 0 {
                        return true
                    } else {
                        return false
                    }
                case .failure(let err):
                    dprint(err.errorDescription ?? "错误！🙅")
                    return false
                }
        }
        
        theNums.subscribe(onNext: { (result) in
            switch result {
            case .success(let num):
                dprint("Even: \(num)")
                break
            case .failure(let err):
                dprint(err.errorDescription ?? "错误！🙅")
                break
            }
        }).dispose()
        
    }
    
}
