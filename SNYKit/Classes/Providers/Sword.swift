//
//  Sword.swift
//  NU
//
//  Created by Sunny on 15/05/2018.
//  Copyright © 2018 Juejin-Inc. All rights reserved.
//

import UIKit

// MARK: - Global Vars
public let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
public let defaults = UserDefaults.standard
public let defaultNoti = NotificationCenter.default
public let uuid = UIDevice.current.identifierForVendor?.uuidString
public var documentsDirectory: URL = {
    let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return urls[urls.count - 1]
}()

// 无Release打印
public func dprint(_ item: Any) {
    #if DEBUG
    print(item)
    #else
    #endif
}
