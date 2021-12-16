//
//  PageDataMode.swift
//  Client
//
//  Created by Shuangquan on 11/15/21.
//

import Foundation

struct PageDataModel: Decodable, CustomStringConvertible {
    
    let pageID: String
    let expiry: String
    let components: [ComponentDataMode]
    
    init() {
        pageID = "0"
        self.expiry = "0"
        self.components = []
    }

    var description: String {
        return pageID.description
    }
    
}
