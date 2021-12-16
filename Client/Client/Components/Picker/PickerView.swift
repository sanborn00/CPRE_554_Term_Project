//
//  PickerView.swift
//  Client
//
//  Created by xiao liang on 12/13/21.
//

import SwiftUI

struct PickerView: View {
    @ObservedObject var viewModel:PickerViewModel

    init(viewModel: PickerViewModel){
        self.viewModel=viewModel
    }
    var body: some View {
        viewModel.style()
            }
        }

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(viewModel: PickerViewModel(itemDataModel: ItemDataModel(text: "Select Item", color:"green", itemName: "Style3", payload: ["one","two","three"])))
    }
}
