//
//  Sword.swift
//  NU
//
//  Created by Sunny on 15/05/2018.
//  Copyright © 2018 Juejin-Inc. All rights reserved.
//

import UIKit
import CoreTelephony
import Reachability
import Photos
import AVFoundation

// 无Release打印
public func dprint(_ item: Any) {
    #if DEBUG
    print(item)
    #else
    #endif
}

open class SNY {
    
    // MARK: - App当前状态
    public static let appStates = AppStates.shared
    
    // MARK: - 屏幕尺寸
    public static let screen = Screen.shared
    
    // MARK: - GCD
    public static let gcd = GCD.shared
    
    // MARK: - App当前版本
    public static let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
    // MARK: - UserDefaults
    public static let defaults = UserDefaults.standard
    
    // MARK: - Default Notification
    public static let defaultNoti = NotificationCenter.default
    
    // MARK: - UUID
    public static let uuid = UIDevice.current.identifierForVendor?.uuidString
    
    // MARK: - Documents目录位置
    public static var documentsPath: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count - 1]
    }()
    
    // 启动动画
    open class func launchAnimation() {
        let vc = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateViewController(withIdentifier: "LaunchScreen")
        let launchView = vc.view
        let mainWindow = UIApplication.shared.keyWindow
        launchView?.frame = screen.frame
        mainWindow?.addSubview(launchView!)
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .beginFromCurrentState, animations: {
            launchView?.alpha = 0.0
            launchView?.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0, 2.0, 1.0)
        }) { (_) in
            launchView?.removeFromSuperview()
        }
    }
    
    // MARK: - 获取运营商信息
    open class func getCarrier() -> (carrierName: String, countryCode: String, networkType: String)? {
        let info = CTTelephonyNetworkInfo()
        if let carrier = info.subscriberCellularProvider {
            if let currentRadioTech = info.currentRadioAccessTechnology {
                dprint("数据业务信息：\(currentRadioTech)")
                dprint("网络制式：\(SNY.getNetworkType(currentRadioTech: currentRadioTech))")
                dprint("运营商名字：\(carrier.carrierName ?? "unknown")")
                dprint("移动国家码(MCC)：\(carrier.mobileCountryCode ?? "unknown")")
                dprint("移动网络码(MNC)：\(carrier.mobileNetworkCode ?? "unknown")")
                dprint("ISO国家代码：\(carrier.isoCountryCode?.uppercased() ?? "unknown")")
                dprint("是否允许VoIP：\(carrier.allowsVOIP)")
                return (carrier.carrierName ?? "unknown", carrier.mobileCountryCode ?? "unknown", SNY.getNetworkType(currentRadioTech: currentRadioTech))
            }
        }
        return nil
    }
    
    open class func getNetworkType(currentRadioTech: String?) -> String {
        if currentRadioTech == nil {
            return "unknown"
        }
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
    
    // MARK: - 权限
    
    //网络类型 (或用于权限判断)
    public static var networkType: Reachability.Connection {
        let reachability = Reachability()!
        return reachability.connection
    }
    
    //相册权限
    public static var photoAlbumPermission: PHAuthorizationStatus {
        let status = PHPhotoLibrary.authorizationStatus()
        return status
    }
    
    //相机权限
    public static var cameraPermission: AVAuthorizationStatus {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        return status
    }
    
    //麦克风权限
    public static var microphonePermission: AVAuthorizationStatus {
        let status = AVCaptureDevice.authorizationStatus(for: .audio)
        return status
    }
    
    //推送权限
    public static var pushPermission: Bool {
        if UIApplication.shared.currentUserNotificationSettings == nil {
            return false
        } else {
            if Int(UIApplication.shared.currentUserNotificationSettings!.types.rawValue) == 0 {
                return false
            } else {
                return true
            }
        }
    }
    
    //判断GPS服务是否可用
    public static var locationPermission: Bool {
        if CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
            return true
        } else {
            return false
        }
    }
    
}
