//
//  UIColor.swift
//  NU
//
//  Created by Sunny on 2018/7/30.
//  Copyright © 2018 Juejin-Inc. All rights reserved.
//

public extension UIColor {
    
    public convenience init(r: Int, g: Int, b: Int) {
        assert(r >= 0 && r <= 255, "Red数值有误")
        assert(g >= 0 && g <= 255, "Green数值有误")
        assert(b >= 0 && b <= 255, "Blue数值有误")
        
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: 1.0)
    }
    
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
    
    // Cached colors
    
    public class var mainTheme: UIColor {
        return UIColor(hex: 0x597EF7)
    }
    
    public class var tabGrayFont: UIColor {
        return UIColor(hex: 0x989898)
    }
    
    public class var normalBack: UIColor {
        return UIColor(hex: 0xf3f5f9)
    }
    
    public class var separator: UIColor {
        return UIColor(hex: 0xe5e5e5)
    }
    
    public class var tabLine: UIColor {
        return UIColor(hex: 0xf3f3f3)
    }
    
    public class var mostBlack: UIColor {
        return UIColor(hex: 0x262626)
    }
    
    public class var midBlack: UIColor {
        return UIColor(hex: 0x656565)
    }
    
    public class var leastBlack: UIColor {
        return UIColor(hex: 0x989898)
    }
    
}
