//
//  ListViewModel.swift
//  Client
//
//  Created by xiao liang on 12/12/21.
//

import SwiftUI

class ListViewModel : ObservableObject {
    
    @Published var itemDataModel: ItemDataModel
    init(itemDataModel: ItemDataModel) {
        self.itemDataModel = itemDataModel
    }
    
    }
    


