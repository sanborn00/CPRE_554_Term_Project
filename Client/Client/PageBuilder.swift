//
//  PageBuilder.swift
//  Client
//
//  Created by Shuangquan on 11/22/21.
//

import Foundation
import Combine
import SwiftUI

@available(iOS 15.0, *)
class PageBuilder: ObservableObject {
    
    @Published var pageComponents: [ComponentDataMode]
    
    var itemDataModel: ItemDataModel?
    
    init(){
        
        self.pageComponents = [.init(variant: .tabNav, data: "n/a")]
    }
    
    func decodePageData() {
        
        if let url = URL(string: "https://sdui-demo-cs554.herokuapp.com/LayoutTest01") {
            _ = Task {
                do {
                    let pageData: PageDataModel = try await fetch(url: url)
                    DispatchQueue.main.async {
                        self.pageComponents = pageData.components
                    }
                    print("data: \(pageData.pageID)")
                    print("data: \(pageData.components)")
                    print("data: \(pageData.description)")
                    
                    
                    
                } catch let error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func buildComponent(variant: Variant) -> AnyView {
        
        switch variant {
            
        case .button:
            return AnyView(Button("a button"){})
            
        case .list:
            return AnyView(VStack {
                Text("item a")
                Text("item b")
                Text("item c")
            })
            
        case .tabNav:
           return AnyView(Text("3"))
            
        case .textField:
           return AnyView(Text("Enter your name"))
            
        case .label:

            let labelViewModel = LabelViewModel(itemDataModel: itemDataModel!)
            
            return AnyView(LabelView(viewModel: labelViewModel))
            
        }
        
    }
        
        
    
    
    
}
    
    

