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
        
        SNY.launchAnimation()
        
        SNY.gcd.main
        
        Lesson3.start()
        
        
    }

    @IBAction func helloAction(_ sender: Any) {
        let alert = UIAlertController(title: "Yes", message: "You tap the button", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "NO", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


