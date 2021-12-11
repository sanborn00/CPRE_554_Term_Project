//
//  LabelView.swift
//  Client
//
//  Created by Shuangquan on 11/22/21.
//

import Foundation
import SwiftUI

struct LabelView: View {

    @ObservedObject var viewModel: LabelViewModel
    
    init(viewModel: LabelViewModel){
        self.viewModel = viewModel
    }
    
    var body: some View {

        Text(viewModel.itemDataModel.text ?? "Loading...")
            .foregroundColor(Color(viewModel.itemDataModel.color ?? "black"))
            
    }

}

