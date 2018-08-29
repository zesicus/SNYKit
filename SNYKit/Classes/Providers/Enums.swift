//
//  Enums.swift
//  NU
//
//  Created by Sunny on 2018/7/31.
//  Copyright © 2018 Juejin-Inc. All rights reserved.
//

import Foundation

//弹出页面的方式 push or present
public enum ShowVCKind {
    case present
    case push
}

//Push返回，选择跳过页面返回还是直接返回上一页
public enum PopKind {
    case direct
    case skip
}
