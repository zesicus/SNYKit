//
//  CGFloat.swift
//  NU
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

public extension CGFloat {
    
    /// Randomly returns either 1.0 or -1.0.
    static var randomSign: CGFloat {
        get {
            return (arc4random_uniform(2) == 0) ? 1.0 : -1.0
        }
    }
    
    /// Returns a random floating point number between 0.0 and 1.0, inclusive.
    static var random: CGFloat {
        get {
            return CGFloat(Float(arc4random()) / Float(UInt32.max))
        }
    }
    
    /// Random CGFloat between 0 and n-1.
    ///
    /// - Parameter n:  Interval max
    /// - Returns:      Returns a random CGFloat point number between 0 and n max
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return CGFloat.random * (max - min) + min
    }
}
