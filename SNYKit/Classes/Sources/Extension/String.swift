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
    
    func transformToPinYin() -> String {
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        return string.replacingOccurrences(of: " ", with: "")
    }
    
    //获取字符串宽度
    func getWidth(size: CGFloat) -> CGFloat {
        return self.size(withAttributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: size)]).width
    }
    
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: [.documentType: NSAttributedString.DocumentType.html,
                                                                      .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            dprint(error)
            return nil
        }
    }
    
    var html2String: String {
        get {
            return html2AttributedString?.string ?? ""
        }
    }
    
    //获得带有行间距的字符串
    func getLineSpacing(lineSpacing: CGFloat = 10.0, charSpacing: CGFloat = 1) -> NSMutableAttributedString {
        let paragraphStye = NSMutableParagraphStyle()
        //调整行间距
        paragraphStye.lineSpacing = lineSpacing
        paragraphStye.lineBreakMode = NSLineBreakMode.byWordWrapping
        let attributedString = NSMutableAttributedString.init(string: self, attributes: [NSAttributedString.Key.paragraphStyle:paragraphStye, NSAttributedString.Key.kern: charSpacing])
        //*******  Additional 将 [展开] 颜色变掉   *******
        let speStr = "[展开]"
        let theStr = self.substring(fromIndex: self.count - 4)
        if speStr == theStr {
            attributedString.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], range: NSMakeRange(self.count - 4, 4))
        }
        let otherSpeStr = "[收起]"
        let otherStr = self.substring(fromIndex: self.count - 4)
        if otherSpeStr == otherStr {
            attributedString.setAttributes([NSAttributedString.Key.foregroundColor: UIColor.blue], range: NSMakeRange(self.count - 4, 4))
        }
        //**************************************************
        return attributedString
    }
    
    //备份标记不同步iCloud
    func excludeFromBackup() {
        var fileToExclude = URL.init(fileURLWithPath: self)
        do {
            var resourceValues = URLResourceValues()
            resourceValues.isExcludedFromBackup = true
            try fileToExclude.setResourceValues(resourceValues)
        } catch {
            dprint(error.localizedDescription)
        }
    }
    
    var urlEscaped: String {
        get {
            return self.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
        }
    }
    
    var urlEncoded: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    }
    
    var utf8Encoded: Data {
        get {
            return self.data(using: .utf8)!
        }
    }
    
    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, self.count) ..< self.count]
    }
    
    fileprivate subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }
    
    //截取字符串到Index
    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }
    
    fileprivate subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(self.count, r.lowerBound)), upper: min(self.count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }
    
    func subString(fromIndex: Int, toIndex: Int) -> String {
        return self[min(fromIndex, self.count) ..< max(0, toIndex)]
    }
    
    //转化为字符数组
    func toCharArray() -> [String] {
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
    
    //隐藏名字(用*代替)
    var hideName: String {
        get {
            var formatedName = ""
            var charArr = [String]()
            for (index, char) in self.toCharArray().enumerated() {
                if index == 0 {
                    charArr.append(char)
                } else {
                    charArr.append("*")
                }
            }
            for char in charArr {
                formatedName += char
            }
            return formatedName
        }
    }
    
    //隐藏手机号码
    var hidePhone: String {
        get {
            var formatedPhone = ""
            var charArr = [String]()
            for (index, char) in self.toCharArray().enumerated() {
                switch index {
                case 3, 4, 5, 6:
                    charArr.append("*")
                    break
                default:
                    charArr.append(char)
                    break
                }
            }
            for char in charArr {
                formatedPhone += char
            }
            return formatedPhone
        }
    }
    
    //隐藏身份证号
    var hideIDCardNo: String {
        get {
            var formatedIDCardNo = ""
            var charArr = [String]()
            for (index, char) in self.toCharArray().enumerated() {
                switch index {
                case 4, 5, 6, 7, 8, 9, 10, 11, 12, 13:
                    charArr.append("*")
                    break
                default:
                    charArr.append(char)
                    break
                }
            }
            for char in charArr {
                formatedIDCardNo += char
            }
            return formatedIDCardNo
        }
    }
    
    //倒计时
    @available (iOS 10.0, *)
    func countDown(dateFormat: String, _ completion: @escaping (String, String, String, String) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        //结束时间
        let endDateFormatter = DateFormatter()
        endDateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let endDate = Date().addingTimeInterval(dateFormatter.date(from: self)!.timeIntervalSince(endDateFormatter.date(from: "2000-01-01 00:00:00")!))
        
        //当前时间
        let currentDate = Date.init()
        
        let calendar = Calendar.current
        let unit:Set<Calendar.Component> = [.day,.hour,.minute,.second]
        let commponent:DateComponents = calendar.dateComponents(unit, from: currentDate, to: endDate)
        
        var secondStr = commponent.second
        var minitStr = commponent.minute
        var hourStr = commponent.hour
        var dayStr = commponent.day
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (timer) in
            
            if  secondStr == 0 && minitStr! == 0 && hourStr == 0 && dayStr == 0 {
                timer.invalidate()
            }
            
            secondStr = secondStr! - 1
            
            if secondStr == -1 {
                secondStr = 59
                minitStr = minitStr! - 1
                if minitStr == -1 {
                    minitStr = 59
                    hourStr = hourStr! - 1
                    if hourStr == -1 {
                        hourStr = 23
                        dayStr = dayStr! - 1
                    }
                }
            }
            
            completion(String(dayStr ?? 0), String(hourStr ?? 0), String(minitStr ?? 0), String(secondStr ?? 0))
        }
        
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
    }
    
}
