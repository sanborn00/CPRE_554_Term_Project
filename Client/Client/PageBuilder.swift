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
    
    @Published private var pageComponents: [ComponentDataMode] = []
    private let publisher = PassthroughSubject<PageDataModel, Never>()
    private var timer: DispatchSourceTimer?

    init(){
        decodePageData()
    }
    
    @ViewBuilder
    var view: some View {
        ScrollView{
            ForEach(pageComponents, id: \.self) { component in
                self.buildComponent(componentID: component.id ,variant: component.variant)
            }
            .onAppear{
                self.bindExpiry()
            }
            .onDisappear{
                self.unbindExpiry()
            }
            .onReceive(publisher){ [self] pageData in
                print("??? \(pageData.components)")
                self.pageComponents.removeAll()
                self.pageComponents.append(contentsOf: pageData.components)
            }
        }
    }
    
    @ViewBuilder
    func buildView(pageComponents: [ComponentDataMode]) -> some View {
        
        ScrollView{
            ForEach(pageComponents, id: \.self) { component in
                self.buildComponent(componentID: component.id ,variant: component.variant)
            }
            .onAppear{
                self.bindExpiry()
            }
            .onReceive(publisher){ [self] pageData in
                print("??? \(pageData.components)")
                self.pageComponents.removeAll()
                self.pageComponents.append(contentsOf: pageData.components)
                
            }
        }
    }
    
    
    func decodePageData() {
        
        if let url = URL(string: "http://192.168.1.109:8080/LayoutTest01") {
            _ = Task {
                do {
                    let data: PageDataModel = try await fetch(url: url)
                    DispatchQueue.main.async {
                        self.pageComponents.append(contentsOf: data.components)
                    }
                } catch let error {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func buildComponent(componentID: String, variant: Variant) -> AnyView {
        
        switch variant {
            
        case .button:
            
            let itemDataModels: [ItemDataModel] = decodeItemDataModel(componentID: componentID, variant: .button)
            
            
            return AnyView (
                ForEach (itemDataModels, id: \.self ) { itemDataModel in
                    ButtonView(viewModel: ButtonViewModel(itemDataModel: itemDataModel))
                }
            )
            
        case .list:
            
            let itemDataModels: [ItemDataModel] = decodeItemDataModel(componentID: componentID, variant: .list)
            
            
            return AnyView(
                ForEach (itemDataModels, id: \.self ) { itemDataModel in
                    ListView(viewModel: ListViewModel(itemDataModel: itemDataModel))
                }.frame(width: UIScreen.main.bounds.size.width, height: 100))
            
        case .picker:
            let itemDataModels: [ItemDataModel] = decodeItemDataModel(variant: .picker)

            
            return AnyView(
                ForEach (itemDataModels, id: \.self ) { itemDataModel in
                    PickerView(viewModel: PickerViewModel(itemDataModel: itemDataModel))
            })
            
        case .tabNav:
            return AnyView(Text("3"))
            
        case .textField:
            
            return AnyView(Text("Enter your name"))
            
        case .label:
            
            let itemDataModels: [ItemDataModel] = decodeItemDataModel(componentID: componentID, variant: .label)
            
            return AnyView (
                ForEach (itemDataModels, id: \.self ) { itemDataModel in
                    LabelView(viewModel: LabelViewModel(itemDataModel: itemDataModel))
                }
            )
            
        case .icon:
            
            let itemDataModels: [ItemDataModel] = decodeItemDataModel(componentID: componentID, variant: .icon)
            
            return AnyView (
                ForEach (itemDataModels, id: \.self ) { itemDataModel in
                    IconView(viewModel: IconViewModel(itemDataModel: itemDataModel))
                }
            )
        }
    }
    
    
    private func decodeItemDataModel(componentID: String, variant: Variant) -> [ItemDataModel] {
        
        var itemDataModels: [ItemDataModel] = []
        
        let components = self.pageComponents.filter{
            $0.variant == variant && $0.id == componentID
        }
        
        for (index, _) in components.enumerated() {
            itemDataModels.append(components[index].itemDataModel)
        }
        
        return itemDataModels
    }
    
    
    func bindExpiry() {
        let queue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".timer")
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer!.schedule(deadline: .now()+5, repeating: .seconds(20))
        timer!.setEventHandler { [weak self] in
            
            DispatchQueue.main.async {
                // update model objects and/or UI here
                refresh(publisher: self!.publisher, url: "http://192.168.1.109:8080/ItemModelUpdate", pageID: "1", itemID: "3244")
            }
        }
        timer!.resume()
    }
    
    func unbindExpiry() {
        timer?.cancel()
        timer = nil
    }
    
}
