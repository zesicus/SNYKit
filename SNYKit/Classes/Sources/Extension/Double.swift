//
//  Double.swift
//  NU
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import Foundation

public extension Double {
    
    //保留X位小数
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    static var random: Double {
        get {
            return Double(arc4random()) / Double(UInt32.max)
        }
    }
    
    /// Random double between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random double point number between 0 and n max
    static func random(min: Double, max: Double) -> Double {
        return Double.random * (max - min) + min
    }
    
    //解决精度丢失
    var decimalStr: String {
        get {
            let doubleString = String(format: "%lf", self)
            let preciseNum = NSDecimalNumber(string: doubleString)
            return preciseNum.stringValue
        }
    }
}
