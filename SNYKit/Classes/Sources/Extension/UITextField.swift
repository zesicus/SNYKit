//
//  UITextField.swift
//  Alamofire
//
//  Created by Nuggets on 2018/11/12.
//

import Foundation

public extension UITextField {
    
    func setPlaceholder(_ str: String, color: UIColor? = nil, font: UIFont? = nil) {
        if color != nil && font != nil {
            self.attributedPlaceholder = NSAttributedString(string: str, attributes: [.foregroundColor: color!, .font: font!])
        } else if color != nil && font == nil {
            self.attributedPlaceholder = NSAttributedString(string: str, attributes: [.foregroundColor: color!])
        } else if color == nil && font != nil {
            self.attributedPlaceholder = NSAttributedString(string: str, attributes: [.font: font!])
        } else {
            self.placeholder = str
        }
    }
    
}
