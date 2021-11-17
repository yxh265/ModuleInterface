//
//  ViewController.swift
//  AModule
//
//  Created by yxh265 on 11/05/2021.
//  Copyright (c) 2021 yxh265. All rights reserved.
//

import UIKit
import AModule

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = AModule()
        a.config()
        
        a.actionA()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

