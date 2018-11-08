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
        
        switch SNY.netPermission {
        case .notRestricted:
            dprint("无限制")
            break
        case .restricted:
            dprint("网络限制")
            break
        case .restrictedStateUnknown:
            dprint("权限未知")
            break
        default:
            break
        }
        
    }

}


