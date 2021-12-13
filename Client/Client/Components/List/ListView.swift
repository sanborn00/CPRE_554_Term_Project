//
//  ListView.swift
//  Client
//
//  Created by xiao liang on 12/12/21.
//

import SwiftUI
import Foundation

struct ListView: View {
    @ObservedObject var viewModel:ListViewModel
    
    var payload: [String]
    
    init(viewModel: ListViewModel){
        self.viewModel=viewModel
        payload = viewModel.itemDataModel.payload ?? []
    }
    
    var body: some View {
        
        List{
            ForEach(payload, id: \.self){ item in
                Text(item)
            }
            
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let payload = ["a","b","c"]
        let itemDataModel = ItemDataModel(payload:payload)
        let listViewModel = ListViewModel(itemDataModel: itemDataModel)
        ListView(viewModel: listViewModel)
    }
}
