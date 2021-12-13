//
//  IconViewModel.swift
//  Client
//
//  Created by Shuangquan on 12/12/21.
//

import SwiftUI

class IconViewModel: ObservableObject {
    @Published var itemDataModel: ItemDataModel
    
    init(itemDataModel: ItemDataModel) {
        self.itemDataModel = itemDataModel
    }
}
