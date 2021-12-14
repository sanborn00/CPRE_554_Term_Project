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
    case icon // 6
}

struct ComponentDataMode: Decodable, Hashable {
    
    var id: String
    let variant: Variant
    let expiry: String
    let itemDataModel: ItemDataModel
    var description: String {
        return "component data model"
    }
    
    static func == (lhs: ComponentDataMode, rhs: ComponentDataMode) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    
}
