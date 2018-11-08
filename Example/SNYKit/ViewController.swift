//
//  ViewController.swift
//  SNYKit
//
//  Created by zesicus on 08/28/2018.
//  Copyright (c) 2018 zesicus. All rights reserved.
//

import UIKit
import SNYKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //网络权限
        switch SNY.networkType {
        case .wifi:
            dprint("wifi")
            break
        case .cellular:
            dprint("移动网络")
            break
        case .none:
            dprint("无网络")
            break
        }
        
        //相册权限
        switch SNY.photoAlbumPermission {
        case .authorized:
            dprint("已授权")
            break
        case .denied:
            dprint("已阻止")
            break
        case .notDetermined:
            dprint("未知")
            break
        case .restricted:
            dprint("未授权，可能是家长控制权限")
            break
        }
        
        //相机权限
        switch SNY.cameraPermission {
        case .authorized:
            dprint("已授权相机")
            break
        case .denied:
            dprint("拒绝使用相机")
            break
        case .restricted:
            dprint("受限制的")
            break
        case .notDetermined:
            dprint("系统未知，可能第一次开启app时状态是这样的")
            break
        }
        
        //麦克风权限
        switch SNY.microphonePermission {
        case .authorized:
            dprint("已授权麦克风")
            break
        case .denied:
            dprint("已拒绝麦克风")
            break
        case .restricted:
            dprint("受限制的")
            break
        case .notDetermined:
            dprint("系统未知，可能第一次开启app时状态是这样的")
            break
        }
        
        //推送权限
        if SNY.pushPermission {
            dprint("推送已开启")
        } else {
            dprint("推送未开启/未知")
        }
        
        //位置
        if SNY.locationPermission {
    dprint("GPS可用")
} else {
    dprint("GPS不可用")
}
        
    }

}


