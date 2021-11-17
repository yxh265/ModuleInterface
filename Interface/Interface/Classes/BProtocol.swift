//
//  BProtocol.swift
//
//  Created by yuxuhong on 2021/11/5.
//

import Foundation

public protocol BProtocol: BaseProtocol {
    // B模块需要对外的接口统一定义到这里
    func getBModuleValue(b: String, callback: ((Int)->Void)) -> Int
}
