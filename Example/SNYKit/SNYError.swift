//
//  SNYError.swift
//  SNYKit_Example
//
//  Created by Sunny on 2019/6/1.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

enum SNYError: LocalizedError {

    case convertFailed
    
    var errorDescription: String? {
        switch self {
        case .convertFailed:
            return "转化失败"
        }
    }
    
}
