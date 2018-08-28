//
//  Profile.swift
//  CashBox
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import UIKit

public struct Profile {
    public static var img: UIImage! = (defaults.object(forKey: DefaultsKey.profileImg) != nil) ? UIImage(data: defaults.object(forKey: DefaultsKey.profileImg) as! Data) : #imageLiteral(resourceName: "default_head")
    public static var imgAddr = defaults.object(forKey: DefaultsKey.profileImgAddr) as? String
    public static var phone = defaults.object(forKey: DefaultsKey.phone) as? String
    public static var nickName = defaults.object(forKey: DefaultsKey.nickName) as? String
    public static var address = defaults.object(forKey: DefaultsKey.address) as? String
    public static var email = defaults.object(forKey: DefaultsKey.email) as? String
    public static var userID = defaults.object(forKey: DefaultsKey.userId) as? Int ?? -99 {
        didSet {
            Sign.isLoginInvalid = Profile.userID != -99 ? false : true
        }
    }
    public static var tokenID = defaults.object(forKey: DefaultsKey.token) as? String ?? "" {
        didSet {
            Sign.isLoginInvalid = Profile.tokenID != "" ? false : true
        }
    }
}
