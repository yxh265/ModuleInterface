//
//  ViewController.swift
//  BModule
//
//  Created by yxh265 on 11/05/2021.
//  Copyright (c) 2021 yxh265. All rights reserved.
//

import UIKit
import BModule

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let b = BModule()
        b.config()
        
        b.actionB()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

