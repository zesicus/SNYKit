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
    public func addLeftBarButtonItem(_ navigationItem: UINavigationItem, title: String, titleColor: UIColor, target: Any?, action: Selector?) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)], for: .normal)
        
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)], for: .highlighted)
    }
    
    public func addLeftBarButtonItem(_ navigationItem: UINavigationItem, image: UIImage, target: Any?, action: Selector?) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: target, action: action)
    }
    
    public func addLeftBarButtonItems(_ navigationItem: UINavigationItem, images: [UIImage], dist: CGFloat, target: Any?, action: [Selector]) {
        var barBtnArr = [UIBarButtonItem]()
        let fixBar = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixBar.width = dist
        for (index, img) in images.enumerated() {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
            btn.setImage(img, for: .normal)
            btn.addTarget(target, action: action[index], for: .touchUpInside)
            let barBtn = UIBarButtonItem(customView: btn)
            barBtnArr.append(barBtn)
            if index != images.count - 1 {
                barBtnArr.append(fixBar)
            }
        }
        navigationItem.leftBarButtonItems = barBtnArr
    }
    
    public func addRightBarButtonItem(_ navigationItem: UINavigationItem, title: String, titleColor: UIColor, target: Any?, action: Selector?) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)], for: .normal)
        
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)], for: .highlighted)
    }
    
    public func addRightBarButtonItem(_ navigationItem: UINavigationItem, image: UIImage, target: Any?, action: Selector?) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: target, action: action)
    }
    
    public func addRightBarButtonItems(_ navigationItem: UINavigationItem, images: [UIImage], dist: CGFloat, target: Any?, action: [Selector]) {
        var barBtnArr = [UIBarButtonItem]()
        let fixBar = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixBar.width = dist
        for (index, img) in images.enumerated() {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 22, height: 22))
            btn.setImage(img, for: .normal)
            btn.addTarget(target, action: action[index], for: .touchUpInside)
            let barBtn = UIBarButtonItem(customView: btn)
            barBtnArr.append(barBtn)
            if index != images.count - 1 {
                barBtnArr.append(fixBar)
            }
        }
        navigationItem.rightBarButtonItems = barBtnArr
    }
    
    //单按钮提示
    public func showBtnAlert(msg: String) {
        let alert = UIAlertController(title: "提示", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}
