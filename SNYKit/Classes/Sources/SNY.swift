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
import Kingfisher

public func dprint(_ item: Any) {
    SNY.dprint(item)
}

open class SNY {
    
    /// App当前状态
    public static let appStates = AppStates.shared
    
    /// GCD
    public static let gcd = GCD.shared
    
    /// App当前版本
    public static let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    
    /// UserDefaults
    public static let defaults = UserDefaults.standard
    
    /// Default Notification
    public static let defaultNoti = NotificationCenter.default
    
    /// UUID
    public static let uuid = UIDevice.current.identifierForVendor?.uuidString
    
    /// Debug 打印
    /// - Parameter item: 对象
    public static func dprint(_ item: Any) {
        #if DEBUG
        print(item)
        #else
        #endif
    }
    
    /// Debug 错误断言
    func dAssertionFailure() {
        #if DEBUG
        assertionFailure()
        #else
        #endif
    }
    
    /// 下载图片
    /// - Parameters:
    ///   - addr: 图片地址
    ///   - completion: 回调图片
    public static func downloadImage(addr: String, _ completion: @escaping (UIImage?) -> Void) {
        let downloader = ImageDownloader.default
        downloader.downloadImage(with: URL(string: addr)!, options: [.cacheOriginalImage]) { result in
            switch result {
            case .success(let value):
                completion(value.image)
            case .failure(let error):
                let img: UIImage? = nil
                completion(img)
                print(error)
            }
        }
    }
    
    // MARK: - 屏幕相关
    
    /// 屏幕尺寸
    public static let screen = Screen.shared
    
    /// 异形屏判断
    /// - Returns: true/false
    public static func isXseries() -> Bool {
        return SNY.safeAreaBottom > 0
    }
    
    /// 状态栏高度
    public static let statusBarHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
    
    /// 导航栏 + 状态栏 高度
    public static let naviBarHeight: CGFloat = 44 + statusBarHeight
    
    /// 底部安全距离高度
    public static let safeAreaBottom: CGFloat = {
        var botHeight: CGFloat = 0
        if #available(iOS 11.0, *) {
            botHeight = UIApplication.shared.keyWindow!.safeAreaInsets.bottom
        } else {
            botHeight = 0
        }
        return botHeight
    }()
    
    /// 禁用屏幕点击事件
    public static func disableTouchScreen() {
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    /// 解禁
    public static func enableTouchScreen() {
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
    
    // MARK: - View 相关
    
    /// 获取 Storyboard ViewController
    /// - Parameters:
    ///   - theClass: MyVC.self
    ///   - storyboardName: 文件名，比如 "Main"
    /// - Returns: ViewController
    public static func getStorybardVC(theClass: AnyClass, storyboardName: String) -> UIViewController {
        let sb = UIStoryboard(name: storyboardName, bundle: nil)
        let className = NSStringFromClass(theClass).components(separatedBy: ".").last!
        return sb.instantiateViewController(withIdentifier: className)
    }
    
    /// 加载 Nib View
    /// - Parameter theClass: 类型 如 MyView.self
    /// - Returns: View
    public static func loadNib(_ theClass: AnyClass) -> View? {
        let className = NSStringFromClass(theClass).components(separatedBy: ".").last!
        let v = Bundle.main.loadNibNamed(className, owner: nil, options: nil)?.last as? View
        return v
    }
    
    /// 启动动画
    /// Tips: 设置请注意，使用 LaunchScreen.storyboard 启动，请设置 view controller 的 identifier 为 "LaunchScreen"，请放置在 appDelegate.window.rootViewController 里的 viewDidLoad 中使用。
    /// - Parameter view: rootViewController 中的 View
    open class func launchAnimation(on view: UIView? = UIApplication.shared.keyWindow ) {
        let vc = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateViewController(withIdentifier: "LaunchScreen")
        let launchView = vc.view
        launchView?.frame = screen.frame
        view?.addSubview(launchView!)
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .beginFromCurrentState, animations: {
            launchView?.alpha = 0.0
            launchView?.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0, 2.0, 1.0)
        }) { (_) in
            launchView?.removeFromSuperview()
        }
    }
    
    
    // MARK: - 存储目录 URL
    
    /// Documents目录位置
    public static var documentsPath: URL {
        get {
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
    }
    
    /// 缓存文件夹路径
    public static var cachesPath: URL {
        get {
            return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
        }
    }
    
    
    // MARK: - 运营商网络和地址等
    
    /// 获取运营商信息
    /// - Returns: (运营商名字，城市代码，网络类型)
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
    
    /// 获取网络类型
    /// - Parameter currentRadioTech: CTTelephonyNetworkInfo().currentRadioAccessTechnology
    /// - Returns: 2G|3G|4G|unknown
    open class func getNetworkType(currentRadioTech: String?) -> String {
        if currentRadioTech == nil {
            return "unknown"
        }
        var networkType = ""
        switch currentRadioTech {
        case CTRadioAccessTechnologyGPRS, CTRadioAccessTechnologyEdge, CTRadioAccessTechnologyCDMA1x:
            networkType = "2G"
            break
        case CTRadioAccessTechnologyeHRPD, CTRadioAccessTechnologyHSDPA, CTRadioAccessTechnologyCDMAEVDORev0, CTRadioAccessTechnologyCDMAEVDORevA, CTRadioAccessTechnologyCDMAEVDORevB, CTRadioAccessTechnologyHSUPA, CTRadioAccessTechnologyWCDMA:
            networkType = "3G"
            break
        case CTRadioAccessTechnologyLTE:
            networkType = "4G"
            break
        default:
            networkType = "5G"
            break
        }
        return networkType
    }
    
    // MARK: - 权限
    
    /// 网络类型 (或用于权限判断)
    public static var networkType: Reachability.Connection {
        get {
            let reachability = Reachability()!
            return reachability.connection
        }
    }
    
    /// 相册权限
    public static var photoAlbumPermission: PHAuthorizationStatus {
        get {
            let status = PHPhotoLibrary.authorizationStatus()
            return status
        }
    }
    
    /// 相机权限
    public static var cameraPermission: AVAuthorizationStatus {
        get {
            let status = AVCaptureDevice.authorizationStatus(for: .video)
            return status
        }
    }
    
    /// 麦克风权限
    public static var microphonePermission: AVAuthorizationStatus {
        get {
            let status = AVCaptureDevice.authorizationStatus(for: .audio)
            return status
        }
    }
    
    /// 推送权限
    public static var pushPermission: Bool {
        get {
            let isRegisteredForRemoteNotifications = UIApplication.shared.isRegisteredForRemoteNotifications
            return isRegisteredForRemoteNotifications
        }
    }
    
    /// GPS权限
    public static var locationPermission: Bool {
        get {
            if CLLocationManager.locationServicesEnabled() && (CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse) {
                return true
            } else {
                return false
            }
        }
    }
    
    // MARK: - 功能性处理
    
    /// 复制字符串
    /// - Parameter str: String
    public static func copyStr(_ str: String) {
        UIPasteboard.general.string = str
    }
    
    /// 用于电话薄获取首字母列表
    /// - Parameter names: 所有名字的数组
    /// - Returns: 首字母列表
    public static func getFirstLetterList(_ names: [String]) -> [String] {
        var firstLetterArr = [String]()
        for name in names {
            let firstLetter = getFirstLetterFromString(aString: name)
            firstLetterArr.append(firstLetter)
        }
        let firstLetterSet = Set(firstLetterArr)
        firstLetterArr = Array(firstLetterSet)
        firstLetterArr = firstLetterArr.sorted { (name1, name2) -> Bool in
            return name1.localizedStandardCompare(name2) == .orderedAscending
        }
        return firstLetterArr
    }
    
    /// 传入汉字字符串, 返回大写拼音首字母
    public static func getFirstLetterFromString(aString: String) -> (String) {
        
        // 注意,这里一定要转换成可变字符串
        let mutableString = NSMutableString.init(string: aString)
        // 将中文转换成带声调的拼音
        CFStringTransform(mutableString as CFMutableString, nil, kCFStringTransformToLatin, false)
        // 去掉声调(用此方法大大提高遍历的速度)
        let pinyinString = mutableString.folding(options: String.CompareOptions.diacriticInsensitive, locale: NSLocale.current)
        // 将拼音首字母装换成大写
        let strPinYin = polyphoneStringHandle(nameString: aString, pinyinString: pinyinString).uppercased()
        // 截取大写首字母
        let firstString = strPinYin.substring(toIndex: 1)
        // 判断姓名首位是否为大写字母
        let regexA = "^[A-Z]$"
        let predA = NSPredicate.init(format: "SELF MATCHES %@", regexA)
        return predA.evaluate(with: firstString) ? firstString : "#"
    }
    
    /// 多音字处理
    static func polyphoneStringHandle(nameString:String, pinyinString:String) -> String {
        if nameString.hasPrefix("长") {return "Chang"}
        if nameString.hasPrefix("沈") {return "Shen"}
        if nameString.hasPrefix("厦") {return "Xia"}
        if nameString.hasPrefix("地") {return "Di"}
        if nameString.hasPrefix("重") {return "Chong"}
        
        return pinyinString;
    }
    
    
    /// 验证限制密码
    /// - Parameters:
    ///   - string: 密码字串
    ///   - includeNumber: 是否强制数字（默认 否）
    ///   - includeLetters: 是否强制字母（默认 否）
    ///   - min: 最小字数（默认 6）
    ///   - max: 最大字数（默认 16）
    /// - Returns: 验证结果 true/false
    static func isPassword(string: String, includeNumber: Bool = false, includeLetters: Bool = false, min: Int = 6, max: Int = 16) -> Bool {
        let numberRegex:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "^.*[0-9]+.*$")
        let letterRegex:NSPredicate = NSPredicate(format: "SELF MATCHES %@", "^.*[A-Za-z]+.*$")
        let evaluate4Num = includeNumber ? numberRegex.evaluate(with: string) : true
        let evaluate4Letters = includeLetters ? letterRegex.evaluate(with: string) : true
        if evaluate4Num && evaluate4Letters && string.count >= min && string.count <= max {
            return true
        } else {
            return false
        }
    }
    
    
}
