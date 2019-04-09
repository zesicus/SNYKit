//
//  Int.swift
//  NU
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import Foundation

public extension Int {
    
    // 秒转日期
    func getDate() -> Date {
        let flashDate = Date(timeIntervalSince1970: (TimeInterval(self)))
        return flashDate
    }
    
    // 转字符串格式日期
    func getStringDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = format
        let flashDate = self.getDate()
        let stringDate = dateFormatter.string(from: flashDate)
        return stringDate
    }
    
    // 薪资转化为K
    func getSalary() -> String {
        var salary = ""
        if self >= 100 {
            if (Double(self) / 1000.0) > Double(self / 1000) {
                salary = "\((Double(self) / 1000.0).roundTo(places: 1))k"
            } else {
                salary = "\(self / 1000)k"
            }
        } else {
            salary = "\(self)"
        }
        return salary
    }
    
    /// Returns a random Int point number between 0 and Int.max.
    static var random: Int {
        return Int.random(n: Int.max)
    }
    
    /// Random integer between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random Int point number between 0 and n max
    static func random(n: Int) -> Int {
        return Int(arc4random_uniform(UInt32(n)))
    }
    
    ///  Random integer between min and max
    ///
    /// - Parameters:
    ///   - min:    Interval minimun
    ///   - max:    Interval max
    /// - Returns:  Returns a random Int point number between 0 and n max
    static func random(min: Int, max: Int) -> Int {
        return Int.random(n: max - min + 1) + min
        
    }
}
