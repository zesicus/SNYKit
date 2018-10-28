//
//  GCD.swift
//  CashBox
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import UIKit

public class GCD {
    
    public static let shared = GCD()
    
    //线程
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
    
    //GCD定时器

    lazy var timerContainer = [String: DispatchSourceTimer]()
    
    /// - Parameters:
    ///   - name: 定时器名字
    ///   - timeInterval: 时间间隔
    ///   - queue: 队列
    ///   - repeats: 是否重复
    ///   - action: 执行任务的闭包
    public func scheduledDispatchTimer(WithTimerName name: String?, timeInterval: Double, queue: DispatchQueue, repeats: Bool, action: @escaping () -> Void) {
        
        if name == nil {
            return
        }
        
        var timer = timerContainer[name!]
        if timer == nil {
            timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
            timer?.resume()
            timerContainer[name!] = timer
        }
        //精度0.1秒
        timer?.schedule(deadline: .now(), repeating: timeInterval, leeway: DispatchTimeInterval.milliseconds(100))
        timer?.setEventHandler(handler: { [weak self] in
            action()
            if repeats == false {
                self?.cancleTimer(WithTimerName: name)
            }
        })
    }
    
    /// 取消定时器
    ///
    /// - Parameter name: 定时器名字
    public func cancleTimer(WithTimerName name: String?) {
        let timer = timerContainer[name!]
        if timer == nil {
            return
        }
        timerContainer.removeValue(forKey: name!)
        timer?.cancel()
    }
    
    
    /// 检查定时器是否已存在
    ///
    /// - Parameter name: 定时器名字
    /// - Returns: 是否已经存在定时器
    public func isExistTimer(WithTimerName name: String?) -> Bool {
        if timerContainer[name!] != nil {
            return true
        }
        return false
    }
    
}
