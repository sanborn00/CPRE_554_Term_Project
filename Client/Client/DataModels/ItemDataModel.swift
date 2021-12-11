//
//  ItemDataModel.swift
//  Client
//
//  Created by Shuangquan on 11/22/21.
//

import Foundation
import SwiftUI

class ItemDataModel: Decodable, ObservableObject {
    
    
    
    var text: String?
    var color: String?
    var itemName: String?
    var imageURL: String?
    var iconKey: String?
    var action: String?
    var payload: [String]?
    
    
    internal init(text: String? = nil, color: String? = nil, itemName: String? = nil, imageURL: String? = nil, iconKey: String? = nil, action: String? = nil, payload: [String]? = nil) {
        self.text = text
        self.color = color
        self.itemName = itemName
        self.imageURL = imageURL
        self.iconKey = iconKey
        self.action = action
        self.payload = payload
    }
    
    
}
