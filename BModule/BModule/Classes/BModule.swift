//
//  BModule.swift
//
//  Created by yuxuhong on 2021/11/5.
//

import Foundation
import Interface

public class BModule {
 
    public init() {
        
    }
    
    public func config() {
        ModuleInterface.shared.registProtocol(by: "BProtocol", instance: self)
    }
    
    public func actionB() {
        // B模块里面的逻辑，需要用到A模块的逻辑，这里使用ModuleInterface模块的接口
        let b = ModuleInterface.shared.getAModuleValue(a: "b call a") { value in
            print("===callAModule==result=", value)
        }
        print("===callAModule=result=b=", b)
    }
    
    private func printB(value: String) {
        print("=======printB=========", value)
    }
}

extension BModule: BProtocol {
    // B对外的接口，真实的逻辑实现。比如他还可以调用自己的printB的函数
    public func getBModuleValue(b: String, callback: ((Int)->Void)) -> Int {
        self.printB(value: b)
        callback(10)
        return 10
    }
}
