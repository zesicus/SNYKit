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
    public func setTitleLeftImgRight(title: String, font: UIFont, fontColor: UIColor, image: UIImage, dist: CGFloat = 0.0, state: UIControl.State = .normal) {
        self.setTitle(title, for: state)
        self.setTitleColor(fontColor, for: state)
        self.titleLabel?.font = font
        self.setImage(image.withRenderingMode(.alwaysOriginal), for: state)
        self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: -image.size.width, bottom: 0, right: image.size.width)
        self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: title.getWidth(size: font.pointSize) + dist, bottom: 0, right: -title.getWidth(size: font.pointSize) - dist)
    }
    
    // 设置按钮图片在文字左
    public func setTitleRightImgLeft(title: String, font: UIFont, fontColor: UIColor, image: UIImage, dist: CGFloat = 0.0, state: UIControl.State = .normal) {
        self.setTitle(title, for: state)
        self.setTitleColor(fontColor, for: state)
        self.titleLabel?.font = font
        self.setImage(image.withRenderingMode(.alwaysOriginal), for: state)
        self.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: dist / 2.0, bottom: 0, right: 0)
        self.imageEdgeInsets = UIEdgeInsets.init(top: 0, left: -dist / 2.0, bottom: 0, right: 0)
    }
}
