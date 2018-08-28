//
//  UI.swift
//  CashBox
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import UIKit

public struct UI {
    // 启动动画
    public static func launchAnimation() {
        let vc = UIStoryboard(name: "LaunchScreen", bundle: nil).instantiateViewController(withIdentifier: "LaunchScreen")
        let launchView = vc.view
        let mainWindow = UIApplication.shared.keyWindow
        launchView?.frame = Screen.frame
        mainWindow?.addSubview(launchView!)
        UIView.animate(withDuration: 1.0, delay: 0.5, options: .beginFromCurrentState, animations: {
            launchView?.alpha = 0.0
            launchView?.layer.transform = CATransform3DScale(CATransform3DIdentity, 2.0, 2.0, 1.0)
        }) { (_) in
            launchView?.removeFromSuperview()
        }
    }
}
