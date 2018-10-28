//
//  Sword.swift
//  NU
//
//  Created by Sunny on 15/05/2018.
//  Copyright © 2018 Juejin-Inc. All rights reserved.
//

import UIKit
import CoreTelephony

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

public final class SNY {
    
    // MARK: - 获取运营商信息
    public static func getCarrierName() -> (carrierName: String, countryCode: String, networkType: String)? {
        let info = CTTelephonyNetworkInfo()
        if let carrier = info.subscriberCellularProvider {
            let currentRadioTech = info.currentRadioAccessTechnology!
            print("数据业务信息：\(currentRadioTech)")
            print("网络制式：\(SNY.getNetworkType(currentRadioTech: currentRadioTech))")
            print("运营商名字：\(carrier.carrierName ?? "unknown")")
            print("移动国家码(MCC)：\(carrier.mobileCountryCode ?? "unknown")")
            print("移动网络码(MNC)：\(carrier.mobileNetworkCode ?? "unknown")")
            print("ISO国家代码：\(carrier.isoCountryCode?.uppercased() ?? "unknown")")
            print("是否允许VoIP：\(carrier.allowsVOIP)")
            return (carrier.carrierName ?? "unknown", carrier.mobileCountryCode ?? "unknown", SNY.getNetworkType(currentRadioTech: currentRadioTech))
        }
        return nil
    }
    
    public static func getNetworkType(currentRadioTech: String) -> String {
        var networkType = ""
        switch currentRadioTech {
        case CTRadioAccessTechnologyGPRS:
            networkType = "2G"
            break
        case CTRadioAccessTechnologyEdge:
            networkType = "2G"
            break
        case CTRadioAccessTechnologyeHRPD:
            networkType = "3G"
            break
        case CTRadioAccessTechnologyHSDPA:
            networkType = "3G"
            break
        case CTRadioAccessTechnologyCDMA1x:
            networkType = "2G"
            break
        case CTRadioAccessTechnologyLTE:
            networkType = "4G"
            break
        case CTRadioAccessTechnologyCDMAEVDORev0:
            networkType = "3G"
            break
        case CTRadioAccessTechnologyCDMAEVDORevA:
            networkType = "3G"
            break
        case CTRadioAccessTechnologyCDMAEVDORevB:
            networkType = "3G"
            break
        case CTRadioAccessTechnologyHSUPA:
            networkType = "3G"
            break
        default:
            break
        }
        return networkType
    }
    
}
