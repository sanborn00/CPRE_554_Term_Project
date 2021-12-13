//
//  ButtonView.swift
//  Client
//
//  Created by Shuangquan on 12/12/21.
//

import SwiftUI

struct ButtonView: View {
    
    @ObservedObject var viewModel: ButtonViewModel

    
    var body: some View {
        Button {
            viewModel.action()
        } label: {
            viewModel.image
            Text("\(viewModel.itemDataModel.text ?? "") \(String(viewModel.count))")
        }
        .foregroundColor(viewModel.buttonColor as? Color)
        
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(viewModel: ButtonViewModel(itemDataModel: ItemDataModel(text: "tap me to add", color: "green", action: "action1")))
    }
}
