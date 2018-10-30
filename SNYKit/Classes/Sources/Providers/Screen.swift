//
//  Screen.swift
//  Pods-SNYKit_Example
//
//  Created by Nuggets on 2018/10/30.
//

import UIKit

//屏幕尺寸
public struct Screen {
    public static let shared = Screen()
    public let frame = UIScreen.main.bounds
    public let width = UIScreen.main.bounds.width
    public let height = UIScreen.main.bounds.height
    public let scale = UIScreen.main.scale
}
