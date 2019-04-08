//
//  UIColor.swift
//  NU
//
//  Created by Sunny on 2018/7/30.
//  Copyright © 2018 Juejin-Inc. All rights reserved.
//

public extension UIColor {
    
    // 直接输Int的颜色
    public convenience init(r: Int, g: Int, b: Int) {
        assert(r >= 0 && r <= 255, "Red数值有误")
        assert(g >= 0 && g <= 255, "Green数值有误")
        assert(b >= 0 && b <= 255, "Blue数值有误")
        
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
    
    // 16进制颜色
    public convenience init(hex: Int, alpha: CGFloat = 1) {
        self.init(red: ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(hex & 0xFF)) / 255.0, alpha: alpha)
    }
    
    //纯色图片
    public func getImage() -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context:CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(self.cgColor)
        context.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    //随机颜色
    public static func randomColor() -> UIColor {
        let red = CGFloat(arc4random() % 256) / 255.0
        let green = CGFloat(arc4random() % 256) / 255.0
        let blue = CGFloat(arc4random() % 256) / 255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}
