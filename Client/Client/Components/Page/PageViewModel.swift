//
//  PageViewModel.swift
//  Client
//
//  Created by xiao liang on 12/14/21.
//

import SwiftUI

class PageViewModel: ObservableObject {
    @Published var itemDataModel: ItemDataModel
    
    init(itemDataModel: ItemDataModel) {
        self.itemDataModel = itemDataModel
    }
}
