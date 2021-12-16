//
//  SecondView.swift
//  Client
//
//  Created by Shuangquan on 12/11/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct SecondView: View {
    @State private var count=0
    var selection = ["a", "b", "c"]
    @State private var selecteditem = "a"
    
    var body: some View {
        
        ScrollView{
            Text("this is a label")
                .foregroundColor(.red)
            Text("this is another label")
                .foregroundColor(.green)
            Text("this is a label")
                .foregroundColor(.red)
            Text("this is another label")
                .foregroundColor(.green)
            Button {
                count = count + 1
                print("after: \(self.count)")
            } label: {
                Text("tap me \(self.count)")
                
            }
            .foregroundColor(.blue)
            Button {
                count = count + 1
                print("after: \(self.count)")
            } label: {
                Text("tap me \(self.count)")
            }
            .foregroundColor(.green)

            List {
                Text("item1")
                Text("item2")
            }
            .frame(width: UIScreen.main.bounds.size.width, height: 100)
            
            .foregroundColor(.black)

            
            Text("Select Item")
            Picker( selection: $selecteditem, label: Text("")) {
                ForEach(selection, id: \.self) {
                    Text($0)
                }
            }
            .foregroundColor(.black)
            .pickerStyle(SegmentedPickerStyle())
            
            Image(systemName: "sunrise.fill")
                .foregroundColor(.black)

        }
        
    }
}



@available(iOS 15.0, *)
struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
