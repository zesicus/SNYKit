//
//  UIButton.swift
//  NU
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import UIKit

public extension UIButton {
    // 设置按钮图片在文字右
    public func setTitleLeftImgRight(title: String, font: UIFont, fontColor: UIColor, image: UIImage, dist: CGFloat = 0.0, state: UIControlState = .normal) {
        self.setTitle(title, for: state)
        self.setTitleColor(fontColor, for: state)
        self.titleLabel?.font = font
        self.setImage(image.withRenderingMode(.alwaysOriginal), for: state)
        self.titleEdgeInsets = UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)
        self.imageEdgeInsets = UIEdgeInsetsMake(0, title.getWidth(size: font.pointSize) + dist, 0, -title.getWidth(size: font.pointSize) - dist)
    }
    
    public func setTitleRightImgLeft(title: String, font: UIFont, fontColor: UIColor, image: UIImage, dist: CGFloat = 0.0, state: UIControlState = .normal) {
        self.setTitle(title, for: state)
        self.setTitleColor(fontColor, for: state)
        self.titleLabel?.font = font
        self.setImage(image.withRenderingMode(.alwaysOriginal), for: state)
        self.titleEdgeInsets = UIEdgeInsetsMake(0, dist / 2.0, 0, 0)
        self.imageEdgeInsets = UIEdgeInsetsMake(0, -dist / 2.0, 0, 0)
    }
}
