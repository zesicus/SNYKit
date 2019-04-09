//
//  Date.swift
//  NU
//
//  Created by Sunny on 2018/8/16.
//  Copyright © 2018 Juejin-Inc. All rights reserved.
//

public extension Date {
    
    //Date转String
    func getStringDate(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = format
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
    
    //判别时间
    func judgeTime() -> String {
        if Calendar.current.isDateInToday(self) {
            let components = self.delta(from: Date())
            if abs(components.hour!) >= 1 {
                return "\(abs(components.hour!))小时前"
            } else if abs(components.minute!) >= 1 {
                return "\(abs(components.minute!))分钟前"
            } else {
                return "刚刚"
            }
        } else {
            if Calendar.current.isDateInYesterday(Date()) {
                return "昨天"
            } else {
                return self.getStringDate(format: "yyyy-MM-dd")
            }
        }
    }
    
    func delta(from: Date) -> DateComponents {
        let calendar = Calendar.current
        let unit = calendar.dateComponents([.day, .year, .month, .hour, .minute, .second], from: self as Date, to: from)
        return unit
    }
    
    func isThisYear() -> Bool {
        let calender = Calendar.current
        let nowYear  = calender.dateComponents([.year], from: Date())
        let selfYear = calender.dateComponents([.year], from: self as Date)
        return nowYear == selfYear
    }
    
}
