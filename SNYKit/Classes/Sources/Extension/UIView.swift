//
//  UIView.swift
//  NU
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import UIKit

public extension UIView {
    
    //适用于Alert动画展示效果
    public func animateIn(parentVC: UIViewController, with backgroundView: UIView? = nil) {
        if backgroundView != nil {
            backgroundView!.backgroundColor = UIColor.black.withAlphaComponent(0)
            backgroundView!.frame = SNY.screen.frame
            parentVC.view.addSubview(backgroundView!)
        }
        parentVC.view.addSubview(self)
        if backgroundView != nil {
            UIView.animate(withDuration: 0.2) {
                backgroundView!.backgroundColor = UIColor.black.withAlphaComponent(0.3)
            }
        }
        self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.3) {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
    
    public func animateOut(with backgroundView: UIView? = nil) {
        UIView.animate(withDuration: 0.3, animations: {
            self.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
            self.alpha = 0.2
        }) { (_) in
            self.removeFromSuperview()
        }
        if backgroundView != nil {
            UIView.animate(withDuration: 0.2, animations: {
                backgroundView!.backgroundColor = UIColor.black.withAlphaComponent(0)
            }) { (_) in
                backgroundView!.removeFromSuperview()
            }
        }
    }
    
}
