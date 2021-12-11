//
//  LabelViewModel.swift
//  Client
//
//  Created by Shuangquan on 11/22/21.
//

import Foundation
import SwiftUI
import Combine

class LabelViewModel: ObservableObject {
    
    @Published var itemDataModel: ItemDataModel
    
    init(itemDataModel: ItemDataModel) {
        self.itemDataModel = itemDataModel
    }
    
    
}
