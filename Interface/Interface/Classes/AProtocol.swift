//
//  AProtocol.swift
//
//  Created by yuxuhong on 2021/11/5.
//

import Foundation

public protocol AProtocol: BaseProtocol {
    // A模块需要对外的接口统一定义到这里
    func getAModuleValue(a: String, callback: ((String)->Void)) -> String
}
