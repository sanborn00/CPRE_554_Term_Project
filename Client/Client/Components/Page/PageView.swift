//
//  PageView.swift
//  Client
//
//  Created by xiao liang on 12/14/21.
//

import SwiftUI

struct PageView: View {
    @ObservedObject var viewModel: PageViewModel
    
    init(viewModel: PageViewModel){
        self.viewModel = viewModel
    }
    var body: some View {
    
            VStack{
                HStack{
                    IconView(viewModel: IconViewModel(itemDataModel: ItemDataModel.init(iconKey: "person.crop.circle.badge.exclamationmark")))
                    
                    ButtonView(viewModel: ButtonViewModel(itemDataModel: ItemDataModel(text: "tap me to add", color: "green", action: "action1")))
                        .padding()
                    
                }
                Divider()
                
                PickerView(viewModel: PickerViewModel(itemDataModel: ItemDataModel(text: "Select Item", color:"green", itemName: "Style2", payload: ["one","two","three"])))
                    .padding()
                Divider()
                
                LabelView(viewModel: LabelViewModel(itemDataModel: ItemDataModel(text:"This is label", color: "blue")))
                    .padding()
                Divider()
                
                ListView(viewModel: ListViewModel(itemDataModel: ItemDataModel(color: "red", payload:["a","b","c"])))
    }
}

struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(viewModel: PageViewModel(itemDataModel: ItemDataModel()))
    }
}
}
