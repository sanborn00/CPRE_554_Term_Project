//
//  IconView.swift
//  Client
//
//  Created by Shuangquan on 12/12/21.
//

import SwiftUI

struct IconView: View {
    
    @ObservedObject var viewModel: IconViewModel
    
    init(viewModel: IconViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {
        Image(systemName: viewModel.itemDataModel.iconKey ?? "exclamationmark.icloud")
    }
}

struct IconView_Previews: PreviewProvider {
    static var previews: some View {
        IconView(viewModel: IconViewModel(itemDataModel: ItemDataModel.init(iconKey: "person.crop.circle.badge.exclamationmark")))
    }
}
