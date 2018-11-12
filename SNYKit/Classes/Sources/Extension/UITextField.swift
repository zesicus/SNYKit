//
//  UITextField.swift
//  Alamofire
//
//  Created by Nuggets on 2018/11/12.
//

import Foundation

public extension UITextField {
    
    public func setPlaceholder(color: UIColor) {
        self.setValue(color, forKey: "_placeholderLabel.textColor")
    }
    
}
