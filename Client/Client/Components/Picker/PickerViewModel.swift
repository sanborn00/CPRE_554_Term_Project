//
//  PickerViewModel.swift
//  Client
//
//  Created by xiao liang on 12/13/21.
//

import SwiftUI

class   PickerViewModel : ObservableObject {
    
    @Published var itemDataModel: ItemDataModel
    var payload: [String]
    @State private var selectedPayload = ""
    @State private var selectedPayloadIndex = 0
    
    init(itemDataModel: ItemDataModel) {
        self.itemDataModel = itemDataModel
        payload = itemDataModel.payload ?? []
        
    }
    


    @ViewBuilder
    func style(selection: Binding<Int>) -> some View{
        switch itemDataModel.itemName{
        case "Style1":
            VStack {
                Text(itemDataModel.text ?? "")
                        Picker("payload selection", selection: selection) {
                            ForEach(payload, id: \.self) {
                                Text($0)
                                    .foregroundColor(Color(self.itemDataModel.color ?? "black"))
                                    
                            }
                        }.pickerStyle(MenuPickerStyle())
                    }
                
     case "Style2":
        VStack {
            Text(itemDataModel.text ?? "")
                    Picker("payload selection", selection: selection) {
                        ForEach(payload, id: \.self) {
                            Text($0)
                                .foregroundColor(Color(self.itemDataModel.color ?? "black"))
                        }
                    }.pickerStyle(WheelPickerStyle())
                }
            
        case "Style3":
            VStack {
                Text(itemDataModel.text ?? "")
                Picker( selection: selection, label: Text("")) {
                    ForEach(0 ..< payload.count, id: \.self) {item in
                        Text(self.payload[item]).tag(item)
                            }
                        }.pickerStyle(SegmentedPickerStyle())
                    .foregroundColor(Color(self.itemDataModel.color ?? "black"))
                    }
            
        default:
            VStack {
                Text(itemDataModel.text ?? "")
                        Picker("payload selection", selection: selection) {
                            ForEach(payload, id: \.self) {
                                Text($0)
                            }.foregroundColor(Color(self.itemDataModel.color ?? "black"))
                        }
                    }
            
        }
}
}
