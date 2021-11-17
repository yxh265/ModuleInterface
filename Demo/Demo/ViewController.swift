//
//  ViewController.swift
//  Demo
//
//  Created by yuxuhong on 2021/11/5.
//

import UIKit
import AModule
import BModule

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let a = AModule()
        a.config()
        let b = BModule()
        b.config()
        
        print("call a")
        a.actionA()
        print("call b")
        b.actionB()
        print("finish")
    }
}

