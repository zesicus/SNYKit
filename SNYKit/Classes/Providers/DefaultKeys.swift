//
//  DefaultKeys.swift
//  NU
//
//  Created by Sunny on 2018/7/30.
//  Copyright © 2018 Juejin-Inc. All rights reserved.
//

import UIKit

//预留出一些可能需要用到的，如果你想把一些东西都存储到UserDefaults的话

public struct DefaultsKey {
    public static var token: String {
        return "kToken"
    }
    public static var userId: String {
        return "kUserId"
    }
    public static var nickName: String {
        return "kNickName"
    }
    public static var realName: String {
        return "kRealName"
    }
    public static var inviteCode: String {
        return "kInviteCode"
    }
    public static var phone: String {
        return "kPhone"
    }
    public static var profileImg: String {
        return "NuggetHeadImage"
    }
    public static var profileImgAddr: String {
        return "NuggetHeadImageAddr"
    }
    public static var address: String {
        return "kAddress"
    }
    public static var email: String {
        return "kEmail"
    }
    public static var first: String {
        return "isFirst" + (Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String)
    }
    public static var searchResult: String {
        return "searchResult"
    }
    public static var dailyAwardTime: String {
        return "dailyAward"
    }
    public static var appUnique: String {
        return "kAppUnique"
    }
}
