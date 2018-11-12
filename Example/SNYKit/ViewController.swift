//
//  ViewController.swift
//  SNYKit
//
//  Created by zesicus on 08/28/2018.
//  Copyright (c) 2018 zesicus. All rights reserved.
//

import UIKit
import SNYKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.barTintColor = .blue
        
        addIconFontLeftBarButtonItem(navigationItem, unicode: "\u{e604}", color: .white, target: self, action: #selector(h))

        addIconFontRightBarButtonItem(navigationItem, unicode: "\u{e604}", color: .white, target: self, action: #selector(h))
        
//        addIconFontLeftBarButtonItems(navigationItem, unicodes: ["\u{e604}", "\u{e604}", "\u{e604}"], colors: Array.init(repeating: .white, count: 3), dist: 20, target: self, action: [#selector(h), #selector(h), #selector(h)])
//
//        addIconFontRightBarButtonItems(navigationItem, unicodes: ["\u{e604}", "\u{e604}", "\u{e604}"], colors: Array.init(repeating: .white, count: 3), dist: 20, target: self, action: [#selector(h), #selector(h), #selector(h)])
//        addIconFontLeftBarButtonItems(navigationItem, unicodes: ["\u{e604}", "\u{e604}", "\u{e604}"], dist: 20, target: self, action: [#selector(h), #selector(h), #selector(h)])
    }
    
    @objc func h() {
        
    }

}


