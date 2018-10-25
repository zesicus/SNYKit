//
//  AppStates.swift
//  CashBox
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import UIKit

public struct AppStates {
    
    public static var foreground: Bool {
        let state = UIApplication.shared.applicationState
        return state == .active
    }
    
    public static var background: Bool {
        let state = UIApplication.shared.applicationState
        return state == .background
    }
    
    public static var inactive: Bool {
        let state = UIApplication.shared.applicationState
        return state == .inactive
    }
}
