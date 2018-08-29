//
//  NotiName.swift
//  NU
//
//  Created by Sunny on 2018/7/30.
//  Copyright © 2018 Juejin-Inc. All rights reserved.
//

import UIKit

//预留的通知名称，如果你需要的话

public struct NotiName {
    public static var updateList: Notification.Name {
        return Notification.Name("NotiUpdateList")
    }
    public static var enterForeground: Notification.Name {
        return Notification.Name("EnterForeground")
    }
    public static var refreshExchangeRecord: Notification.Name {
        return Notification.Name("RefreshExchangeRecord")
    }
    public static var didReceiveMsg: Notification.Name {
        return Notification.Name("CCPDidReceiveMessageNotification")
    }
    public static var rightBtnAction: Notification.Name {
        return Notification.Name("rightBtnAction")
    }
    public static var chooseActivityLocs: Notification.Name {
        return Notification.Name("chooseActivityLocs")
    }
    public static var receivedPushNoti: Notification.Name {
        return Notification.Name("receivedPushNoti")
    }
    public static var refreshPosts: Notification.Name {
        return Notification.Name("kRefreshPosts")
    }
}
