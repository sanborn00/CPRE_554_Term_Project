//
//  PageDataMode.swift
//  Client
//
//  Created by Shuangquan on 11/15/21.
//

import Foundation

struct PageDataModel: Decodable, CustomStringConvertible {
    
    let pageID: Int
    let components: [ComponentDataMode]
    
    
    var description: String {
        return pageID.description
    }
    
}
