//
//  ComponentDataModel.swift
//  Client
//
//  Created by Shuangquan on 11/15/21.
//

import Foundation

enum Variant: String, Decodable {
    case button // 1
    case list  // 2
    case tabNav // 3
    case textField // 4
    case label // 5
}

struct ComponentDataMode: Decodable, Hashable {
    let variant: Variant
    let data: String?
    var description: String {
        return "component data model"
    }
}
