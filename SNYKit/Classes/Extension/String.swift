//
//  String.swift
//  NU
//
//  Created by Sunny on 2018/7/16.
//  Copyright © 2018 Nuggets. All rights reserved.
//

import UIKit
import AudioToolbox

public extension String {
    
    // 随机MD5
    /* 使用则导入 #import <CommonCrypto/CommonCrypto.h>
    static func randomMD5() -> String {
        
        let identifier = CFUUIDCreate(nil)
        let identifierString = CFUUIDCreateString(nil, identifier) as String
        let cStr = identifierString.cString(using: .utf8)
        
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        
        CC_MD5(cStr, CC_LONG(strlen(cStr)), &digest)
        
        var output = String()
        
        for i in digest {
            
            output = output.appendingFormat("%02X", i)
        }
        
        return output;
    }
 */
    
    //获取字符串宽度
    public func getWidth(size: CGFloat) -> CGFloat {
        return self.size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: size)]).width
    }
    
    public var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html,
                                                                      .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            dprint(error)
            return nil
        }
    }
    
    public var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    //获得带有行间距的字符串
    public func getLineSpacing(lineSpacing: CGFloat = 10.0, charSpacing: CGFloat = 1) -> NSMutableAttributedString {
        let paragraphStye = NSMutableParagraphStyle()
        //调整行间距
        paragraphStye.lineSpacing = lineSpacing
        paragraphStye.lineBreakMode = NSLineBreakMode.byWordWrapping
        let attributedString = NSMutableAttributedString.init(string: self, attributes: [NSAttributedStringKey.paragraphStyle:paragraphStye, NSAttributedStringKey.kern: charSpacing])
        //*******  Additional 将 [展开] 颜色变掉   *******
        let speStr = "[展开]"
        let theStr = self.substring(fromIndex: self.count - 4)
        if speStr == theStr {
            attributedString.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.mainTheme], range: NSMakeRange(self.count - 4, 4))
        }
        let otherSpeStr = "[收起]"
        let otherStr = self.substring(fromIndex: self.count - 4)
        if otherSpeStr == otherStr {
            attributedString.setAttributes([NSAttributedStringKey.foregroundColor: UIColor.mainTheme], range: NSMakeRange(self.count - 4, 4))
        }
        //**************************************************
        return attributedString
    }
    
    //备份标记不同步iCloud
    public func excludeFromBackup() {
        var fileToExclude = URL.init(fileURLWithPath: self)
        do {
            var resourceValues = URLResourceValues()
            resourceValues.isExcludedFromBackup = true
            try fileToExclude.setResourceValues(resourceValues)
        } catch {
            dprint(error.localizedDescription)
        }
    }
    
    public var urlEscaped: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    public var utf8Encoded: Data {
        return self.data(using: .utf8)!
    }
    
    public func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, self.count) ..< self.count]
    }
    
    fileprivate subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    //截取字符串到Index
    public func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    fileprivate subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(self.count, r.lowerBound)), upper: min(self.count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    //转化为字符数组
    public func toCharArray() -> [String] {
        var chars = [String]()
        for char in self {
            chars.append(String(char))
        }
        return chars
    }
    
    //播放声音
    func playSound() {
        let filePath = Bundle.main.path(forResource: self, ofType: nil)
        if filePath != nil {
            let fileURL = URL(string: filePath!)
            var soundID: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(fileURL! as CFURL, &soundID)
            AudioServicesPlaySystemSound(soundID)
        }
    }
}
