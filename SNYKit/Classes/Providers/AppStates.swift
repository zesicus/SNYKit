//
//  AppStates.swift
//  CashBox
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import UIKit

public struct AppStates {
    
    static func foreground() -> Bool {
        let state = UIApplication.shared.applicationState
        return state == .active
    }
    
    static func background() -> Bool {
        let state = UIApplication.shared.applicationState
        return state == .background
    }
    
    static func inactive() -> Bool {
        let state = UIApplication.shared.applicationState
        return state == .inactive
    }
}
