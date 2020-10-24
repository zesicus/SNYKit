//
//  UIImageView.swift
//  NU
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import UIKit
import Kingfisher

extension UIImageView {
    
    //填充虚线
    public func fillImaginaryLine(color: UIColor) {
        let width = self.frame.size.width
        let height = self.frame.size.height
        UIGraphicsBeginImageContext(self.frame.size)
        self.image?.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        let context:CGContext = UIGraphicsGetCurrentContext()!
        
        context.setLineCap(CGLineCap.square)
        
        let lengths:[CGFloat] = [2,5] // 绘制 跳过 无限循环
        
        context.setStrokeColor(color.cgColor)
        context.setLineWidth(2)
        context.setLineDash(phase: 0, lengths: lengths)
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: width, y: 0))
        context.strokePath()
        
        self.image = UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    //图片蒙版
    public func maskPic(image: UIImage?, with maskImage: UIImage? = UIImage(named: "mask_image")) {
        let maskLayer = CAShapeLayer()
        maskLayer.fillColor = UIColor.black.cgColor
        maskLayer.strokeColor = UIColor.clear.cgColor
        maskLayer.frame = self.bounds
        maskLayer.contentsCenter = CGRect(x: 0.5, y: 0.5, width: 0.1, height: 0.1)
        maskLayer.contentsScale = SNY.screen.scale //自动拉伸效果不变形
        maskLayer.contents = maskImage?.cgImage
        
        let contentLayer = CALayer()
        contentLayer.mask = maskLayer
        contentLayer.contents = image?.cgImage
        contentLayer.frame = self.bounds
        self.layer.addSublayer(contentLayer)
        
        self.layer.mask = maskLayer
        self.layer.frame = self.bounds
        self.image = image
    }
    
    
    // Kingfisher
    //设置及时网络图片（无缓存）
    
    /// 无缓存式设置网络图片
    ///
    /// - Parameters:
    ///   - urlString: 网络图片地址
    ///   - placeholder: 占位图
    public func setNetImgNoCache(urlString: String, placeholder: UIImage? = UIImage(named: "sny_default_img")) {
        let cache = KingfisherManager.shared.cache
        cache.clearDiskCache()//清除硬盘缓存
        cache.clearMemoryCache()//清理网络缓存
        cache.cleanExpiredDiskCache()//清理过期的，或者超过硬盘限制大小的
        self.kf.setImage(with: URL(string: urlString), placeholder: placeholder, options: nil, progressBlock: nil) { (result) in
            do {
                let _ = try result.get()
            } catch let error {
                SNY.dprint(error)
            }
        }
    }
    
    /// 有缓存式设置网络图片
    ///
    /// - Parameters:
    ///   - urlString: 网络图片地址
    ///   - placeholder: 占位图
    public func setNetImg(urlString: String, placeholder: UIImage? = UIImage(named: "sny_default_img")) {
        self.kf.setImage(with: URL(string: urlString), placeholder: placeholder, options: nil, progressBlock: nil) { (result) in
            do {
                let _ = try result.get()
            } catch let error {
                SNY.dprint(error)
            }
        }
    }
}
