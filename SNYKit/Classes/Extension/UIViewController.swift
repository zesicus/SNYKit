//
//  UIViewController.swift
//  NU
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    //左右BarButtonItems
    public func addLeftBarButtonItem(_ navigationItem: UINavigationItem, title: String, target: Any?, action: Selector?) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.mainTheme, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16.0)], for: .normal)
        
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.mainTheme, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16.0)], for: .highlighted)
    }
    
    public func addLefttBarButtonItem(_ navigationItem: UINavigationItem, image: UIImage, target: Any?, action: Selector?) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: target, action: action)
    }
    
    public func addRightBarButtonItem(_ navigationItem: UINavigationItem, title: String, target: Any?, action: Selector?) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.mainTheme, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16.0)], for: .normal)
        
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedStringKey.foregroundColor: UIColor.mainTheme, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 16.0)], for: .highlighted)
    }
    
    public func addRightBarButtonItem(_ navigationItem: UINavigationItem, image: UIImage, target: Any?, action: Selector?) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: target, action: action)
    }
    
    //单按钮提示
    
    public func showBtnAlert(msg: String) {
        let alert = UIAlertController(title: "提示", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
