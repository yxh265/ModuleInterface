//
//  AModule.swift
//
//  Created by yuxuhong on 2021/11/5.
//

import Foundation
import Interface

public class AModule {
    public init() {
        
    }
    
    public func config() {
        ModuleInterface.shared.registProtocol(by: "AProtocol", instance: self)
    }
    
    public func actionA() {
        // A模块里面的逻辑，需要用到B模块的逻辑，这里使用ModuleInterface模块的接口
        let a = ModuleInterface.shared.getBModuleValue(b: "a call b") { value in
            print("==callBModule=result==", value)
        }
        print("==callBModule=result=2=", a)
    }
    
    private func printA(value: String) {
        print("=====printA=====", value)
    }
}

extension AModule: AProtocol {
    // A对外的接口，真实的逻辑实现。比如他还可以调用自己的printA的函数
    public func getAModuleValue(a: String, callback: ((String)->Void)) -> String {
        self.printA(value: a)
        callback("2")
        return "2"
    }
}
