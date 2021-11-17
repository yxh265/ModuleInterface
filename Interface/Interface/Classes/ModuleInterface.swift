//
//  ModuleInterface.swift
//
//  Created by yuxuhong on 2021/11/5.
//

import Foundation

public class ModuleInterface {
    public static let shared = ModuleInterface()
    public var protocols: [String: BaseProtocol] = [:]
    
    public func registProtocol(by name: String, instance: BaseProtocol) {
        self.protocols[name] = instance
    }
    
    public func getProtocol(by name: String) -> BaseProtocol? {
        return self.protocols[name]
    }
}
extension ModuleInterface: AProtocol {
    // A对外的接口，调用逻辑
    public func getAModuleValue(a: String, callback: ((String)->Void)) -> String {
        if let pro = self.getProtocol(by: "AProtocol") as? AProtocol {
            return pro.getAModuleValue(a: a, callback: callback)
        } else {
            print("no found AProtocol instance")
            callback("error")
            return "error"
        }
    }
}
extension ModuleInterface: BProtocol {
    // B对外的接口，调用逻辑
    public func getBModuleValue(b: String, callback: ((Int)->Void)) -> Int {
        if let pro = self.getProtocol(by: "BProtocol") as? BProtocol {
            return pro.getBModuleValue(b: b, callback: callback)
        } else {
            print("no found BProtocol instance")
            callback(0)
            return 0
        }
    }
}
