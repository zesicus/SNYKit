//
//  Sign.swift
//  CashBox
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import UIKit

public struct Sign {
    public static var isLoginAlertShow = false
    public static var isRealNameAlertShow = false
    public static var isLoginVCShown = false
    public static let isNew = defaults.object(forKey: DefaultsKey.first) as? String
    public static var isRealName = defaults.object(forKey: DefaultsKey.realName) as? Bool ?? false
    public static var isLoginInvalid = {
        return Profile.userID != -99 ? false : true
    }()
    
    // 判断App在前后台
    public static var isAppRunningForeground: Bool {
        let state = UIApplication.shared.applicationState
        return state == .active
    }
    
    public static var isAppInBackground: Bool {
        let state = UIApplication.shared.applicationState
        return state == .background
    }
    
    public static var isAppInactive: Bool {
        let state = UIApplication.shared.applicationState
        return state == .inactive
    }
}
