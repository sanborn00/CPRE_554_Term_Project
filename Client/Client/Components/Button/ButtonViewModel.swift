//
//  ButtonViewModel.swift
//  Client
//
//  Created by Shuangquan on 12/12/21.
//

import SwiftUI

class ButtonViewModel: ObservableObject {
    @Published var itemDataModel: ItemDataModel
    @Published var count = 0
    
    init(itemDataModel: ItemDataModel) {
        self.itemDataModel = itemDataModel
        print("init: \(count)")

    }
    
    @ViewBuilder
    var image: some View {
        Image(systemName: itemDataModel.iconKey ?? "")
    }
    
    @ViewBuilder
    var buttonColor: some View {
        Color("\(itemDataModel.color ?? "blue")")
    }
    
    
    func action(){
        switch itemDataModel.action {
        case "action1":
            count = count + 1
            print("after: \(count)")
        case "action2":
            count = count - 1
        case "action3":
            count = 0
        case .none:
            count = -1
        case .some(_):
            count = -2
        }
    }
}


