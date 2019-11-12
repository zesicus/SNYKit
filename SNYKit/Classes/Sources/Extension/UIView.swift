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
    
    func animateIn(parentVC: UIViewController, with backgroundView: UIView? = nil) {
        self.alpha = 1
        if backgroundView != nil {
            backgroundView!.backgroundColor = UIColor.black.withAlphaComponent(0)
            backgroundView!.frame = SNY.screen.frame
            parentVC.view.addSubview(backgroundView!)
        }
        parentVC.view.addSubview(self)
        self.center = CGPoint(x: parentVC.view.center.x, y: parentVC.view.center.y - 30)
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
    
    func animateOut(with backgroundView: UIView? = nil) {
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
    
    // View 向上滑动入场
    
    func slideIn(parentVC: UIViewController, bounds: CGRect, with backgroundView: UIView? = nil) {
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
        self.frame = CGRect(x: (SNY.screen.width - bounds.size.width) / 2, y: SNY.screen.height, width: bounds.size.width, height: bounds.size.height)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
            self.frame = CGRect(x: (SNY.screen.width - bounds.size.width) / 2, y: SNY.screen.height - bounds.size.height, width: bounds.size.width, height: bounds.size.height)
        }, completion: nil)
    }
    
    func slideOut(with backgroundView: UIView? = nil) {
        let viewFrame = self.frame
        UIView.animate(withDuration: 0.3, animations: {
            self.frame = CGRect(x: viewFrame.minX, y: SNY.screen.height, width: viewFrame.size.width, height: viewFrame.size.height)
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
    
    // 顶部通知滑下来弹窗
    
    func slideDown(parentVC: UIViewController, bounds: CGRect) {
        parentVC.view.addSubview(self)
        self.frame = CGRect(x: (SNY.screen.width - bounds.size.width) / 2, y: -bounds.size.height, width: bounds.size.width, height: bounds.size.height)
        UIView.animate(withDuration: 0.3) {
            self.frame = CGRect(x: (SNY.screen.width - bounds.size.width) / 2, y: UIApplication.shared.statusBarFrame.size.height + 10, width: bounds.size.width, height: bounds.size.height)
        }
        SNY.gcd.after(time: 1.5, queue: GCD.main) {
            UIView.animate(withDuration: 0.3, animations: {
                self.frame = CGRect(x: (SNY.screen.width - bounds.size.width) / 2, y: -bounds.size.height, width: bounds.size.width, height: bounds.size.height)
            })
        }
    }
    
    // 获取UIView截图
    func getImage() -> UIImage? {
        UIGraphicsBeginImageContext(self.frame.size)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: false)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
    // 任意角圆弧裁剪
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    /// 底部圆弧裁剪
    ///
    /// - Parameters:
    ///   - rect: View总大小
    ///   - radius: 裁剪半径
    func bottomArc(rect: CGRect, radius: CGFloat) {
        let maskPath = UIBezierPath()
        maskPath.addArc(withCenter: CGPoint(x: rect.size.width / 2, y: rect.size.height - radius), radius: radius, startAngle: 0, endAngle: CGFloat.pi, clockwise: true)
        maskPath.addClip()
        let maskLayer = CAShapeLayer()
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    // 缩放动画
    func bounceAnimation() {
        let impliesAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        impliesAnimation.values = [1.0 ,1.2, 0.9, 1.15, 0.95, 1.02, 1.0]
        impliesAnimation.duration = 0.6
        impliesAnimation.calculationMode = CAAnimationCalculationMode.cubic
        self.layer.add(impliesAnimation, forKey: nil)
    }
    
    // 添加阴影
    func addShadow(blackAlpha: Float, shadowRadius: CGFloat, shadowOffset: CGSize = .zero) {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowOpacity = blackAlpha
        self.layer.shadowRadius = shadowRadius
    }

}
