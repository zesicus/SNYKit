//
//  UIImageView.swift
//  NU
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import UIKit

extension UIImageView {
    
    //填充虚线
    public func fillImaginaryLine() {
        let width = self.frame.size.width
        let height = self.frame.size.height
        UIGraphicsBeginImageContext(self.frame.size)
        self.image?.draw(in: CGRect(x: 0, y: 0, width: width, height: height))
        
        let context:CGContext = UIGraphicsGetCurrentContext()!
        
        context.setLineCap(CGLineCap.square)
        
        let lengths:[CGFloat] = [2,5] // 绘制 跳过 无限循环
        
        context.setStrokeColor(UIColor.separator.cgColor)
        context.setLineWidth(2)
        context.setLineDash(phase: 0, lengths: lengths)
        context.move(to: CGPoint(x: 0, y: 0))
        context.addLine(to: CGPoint(x: width, y: 0))
        context.strokePath()
        
        self.image = UIGraphicsGetImageFromCurrentImageContext()!
    }
    
    
    // 设置及时网络图片（无缓存）
    /*
    public func setNetImgNoCache(urlString: String) {
        let cache = KingfisherManager.shared.cache
        cache.clearDiskCache()//清除硬盘缓存
        cache.clearMemoryCache()//清理网络缓存
        cache.cleanExpiredDiskCache()//清理过期的，或者超过硬盘限制大小的
        self.kf.setImage(with: URL(string: urlString), placeholder: #imageLiteral(resourceName: "default_rect"), options: nil, progressBlock: nil, completionHandler: nil)
    }
    
    public func setNetImg(urlString: String) {
        self.kf.setImage(with: URL(string: urlString), placeholder: #imageLiteral(resourceName: "default_rect"), options: nil, progressBlock: nil, completionHandler: nil)
    }
    */
}
