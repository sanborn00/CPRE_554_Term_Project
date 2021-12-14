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
    
    var pageData: PageDataModel = PageDataModel()
    
    init(){
        pageComponents = []
        decodePageData()
    }
        
    
    func decodePageData() {
        
        if let url = URL(string: "https://sdui-demo-cs554.herokuapp.com/LayoutTest01") {
            _ = Task {
                do {
                    self.pageData = try await fetch(url: url)
                    DispatchQueue.main.async {
                        self.pageComponents = self.pageData.components
                    }
                    print("page id: \(pageData.pageID)")
                    print("components data: \(pageData.components)")
                    print("description: \(pageData.description)")
                    
                    
                    
                } catch let error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func buildComponent(variant: Variant) -> AnyView {
        
        switch variant {
            
        case .button:
            
            let itemDataModels: [ItemDataModel] = decodeItemDataModel(variant: .button)
            
            
            return AnyView (
                ForEach (itemDataModels, id: \.self ) { itemDataModel in
                    ButtonView(viewModel: ButtonViewModel(itemDataModel: itemDataModel))
                }
            )
            
        case .list:
            
            let itemDataModels: [ItemDataModel] = decodeItemDataModel(variant: .list)

            
            return AnyView(List {
                Text("item a")
                Text("item b")
                Text("item c")
            }.frame(width: UIScreen.main.bounds.size.width - 20, height: 100))
            
        case .tabNav:
            return AnyView(Text("3"))
            
        case .textField:
            
            return AnyView(Text("Enter your name"))
            
        case .label:
            
            let itemDataModels: [ItemDataModel] = decodeItemDataModel(variant: .label)
                        
            return AnyView (
                ForEach (itemDataModels, id: \.self ) { itemDataModel in
                    LabelView(viewModel: LabelViewModel(itemDataModel: itemDataModel))
                }
            )
            
        case .icon:
            
            let itemDataModels: [ItemDataModel] = decodeItemDataModel(variant: .icon)
            
            return AnyView (
                ForEach (itemDataModels, id: \.self ) { itemDataModel in
                    IconView(viewModel: IconViewModel(itemDataModel: itemDataModel))
                }
            )
        }
    }
    
    @ViewBuilder
    func refresh(pageComponents:[ComponentDataMode]) -> some View {
            VStack{
                ForEach(pageComponents, id: \.self) { component in
                    self.buildComponent(variant: component.variant)
                }
            }
        
    }
    
    
    private func decodeItemDataModel(variant: Variant) -> [ItemDataModel] {
        
        var itemDataModels: [ItemDataModel] = []
        
        let components = pageData.components.filter{
            $0.variant == variant
        }
        
        pageData.components.removeAll {
            $0.variant == variant
        }
        
        for (index, _) in components.enumerated() {
            itemDataModels.append(components[index].itemDataModel)
        }
        
        return itemDataModels
    }
}
