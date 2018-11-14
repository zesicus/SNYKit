//
//  UIViewController.swift
//  NU
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    // MARK: - Left Bar button item
    
    public func addLeftBarButtonItem(_ navigationItem: UINavigationItem, title: String, titleColor: UIColor, target: Any?, action: Selector?) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)], for: .normal)
        
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)], for: .highlighted)
    }
    
    public func addLeftBarButtonItem(_ navigationItem: UINavigationItem, image: UIImage, target: Any?, action: Selector?) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: target, action: action)
    }
    
    public func addIconFontLeftBarButtonItem(_ navigationItem: UINavigationItem, unicode: String, color: UIColor, target: Any?, action: Selector?, iconSize: CGFloat = 22) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: unicode, style: .plain, target: target, action: action)
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([.font: UIFont.iconFont(ofSize: iconSize), .foregroundColor: color], for: .normal)
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
    
    public func addIconFontLeftBarButtonItems(_ navigationItem: UINavigationItem, unicodes: [String], colors: [UIColor], dist: CGFloat, target: Any?, action: [Selector], iconSize: CGFloat = 22) {
        let fixBar = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixBar.width = dist
        var items = [UIBarButtonItem]()
        for (index, unicode) in unicodes.enumerated() {
            let item = UIBarButtonItem(title: unicode, style: .plain, target: target, action: action[index])
            item.setTitleTextAttributes([.font: UIFont.iconFont(ofSize: iconSize), .foregroundColor: colors[index]], for: .normal)
            items.append(item)
            if index != unicodes.count - 1 {
                items.append(fixBar)
            }
        }
        navigationItem.leftBarButtonItems = items
    }
    
    // MARK: - Right Bar button item
    
    public func addRightBarButtonItem(_ navigationItem: UINavigationItem, title: String, titleColor: UIColor, target: Any?, action: Selector?) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: target, action: action)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)], for: .normal)
        
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16.0)], for: .highlighted)
    }
    
    public func addRightBarButtonItem(_ navigationItem: UINavigationItem, image: UIImage, target: Any?, action: Selector?) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: image.withRenderingMode(.alwaysOriginal), style: .plain, target: target, action: action)
    }
    
    public func addIconFontRightBarButtonItem(_ navigationItem: UINavigationItem, unicode: String, color: UIColor, target: Any?, action: Selector?, iconSize: CGFloat = 22) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: unicode, style: .plain, target: target, action: action)
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([.font: UIFont.iconFont(ofSize: iconSize), .foregroundColor: color], for: .normal)
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
    
    public func addIconFontRightBarButtonItems(_ navigationItem: UINavigationItem, unicodes: [String], colors: [UIColor], dist: CGFloat, target: Any?, action: [Selector], iconSize: CGFloat = 22) {
        let fixBar = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixBar.width = dist
        var items = [UIBarButtonItem]()
        for (index, unicode) in unicodes.enumerated() {
            let item = UIBarButtonItem(title: unicode, style: .plain, target: target, action: action[index])
            item.setTitleTextAttributes([.font: UIFont.iconFont(ofSize: iconSize), .foregroundColor: colors[index]], for: .normal)
            items.append(item)
            if index != unicodes.count - 1 {
                items.append(fixBar)
            }
        }
        navigationItem.rightBarButtonItems = items.reversed()
    }
    
    //单按钮提示
    public func showBtnAlert(msg: String) {
        let alert = UIAlertController(title: "提示", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "确定", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    //禁止自动修改Scroll布局
    public func disableAdjustsScrollViewInsets(_ scrollView: UIScrollView) {
        if #available(iOS 11.0, *) {
            scrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
    
}
