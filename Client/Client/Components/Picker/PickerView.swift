//
//  PickerView.swift
//  Client
//
//  Created by xiao liang on 12/13/21.
//

import SwiftUI

struct PickerView: View {
    @ObservedObject var viewModel:PickerViewModel
    @State private var selectedPayloadIndex = 0


    init(viewModel: PickerViewModel){
        self.viewModel=viewModel
    }
    var body: some View {
        viewModel.style(selection: $selectedPayloadIndex)
            }
        }

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView(viewModel: PickerViewModel(itemDataModel: ItemDataModel(text: "Select Item", color:"green", itemName: "Style3", payload: ["one","two","three"])))
    }
}
