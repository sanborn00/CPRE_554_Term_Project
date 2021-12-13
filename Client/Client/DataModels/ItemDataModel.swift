//
//  ItemDataModel.swift
//  Client
//
//  Created by Shuangquan on 11/22/21.
//

import Foundation
import SwiftUI


enum ActionVariant: String, Decodable {
    case action1
    case action2
    case action3
}

struct ItemDataModel: Decodable, Hashable {
    
    private(set) var text: String?
    private(set) var color: String?
    private(set) var itemName: String?
    private(set) var imageURL: String?
    private(set) var iconKey: String?
    private(set) var action: String?
    private(set) var payload: [String]?
    
    
    internal init(text: String? = nil, color: String? = nil, itemName: String? = nil, imageURL: String? = nil, iconKey: String? = nil, action: String? = nil, payload: [String]? = nil) {
        self.text = text
        self.color = color
        self.itemName = itemName
        self.imageURL = imageURL
        self.iconKey = iconKey
        self.action = action
        self.payload = payload
    }
    
    static func == (lhs: ItemDataModel, rhs: ItemDataModel) -> Bool {
        lhs.text == rhs.text
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(text)
    }
    
}
