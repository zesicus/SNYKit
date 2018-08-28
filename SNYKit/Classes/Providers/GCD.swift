//
//  GCD.swift
//  CashBox
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import UIKit

public struct GCD {
    public static let main = DispatchQueue.main
    public static let global = DispatchQueue.global()
    public static let globalHigh = DispatchQueue.global(qos: .userInteractive)
    public static let seria = DispatchQueue(label: "com.nuggets.nu")
    public static let concurrent = DispatchQueue(label: "com.nuggets.nu", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
    
    public static func after(time: Double, queue: DispatchQueue, callBack: @escaping () -> Void) {
        queue.asyncAfter(deadline: GCD.afterTime(time: time)) {
            callBack()
        }
    }
    
    private static func afterTime(time: Double) -> DispatchTime {
        return DispatchTime.now() + time
    }
}
