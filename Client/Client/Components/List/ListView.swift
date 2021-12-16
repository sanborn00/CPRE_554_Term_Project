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
                    .foregroundColor(Color(viewModel.itemDataModel.color ?? "black"))
            }
            
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView(viewModel: ListViewModel(itemDataModel: ItemDataModel(color: "red", payload:["a","b","c"])))
    }
}
