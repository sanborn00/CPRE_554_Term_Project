//
//  FirstView.swift
//  Client
//
//  Created by Shuangquan on 12/11/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct FirstView: View {
    
    @EnvironmentObject var pageBuilder: PageBuilder
    
    
    var body: some View {
        view
            
        
//            .onAppear {
//                pageBuilder.decodePageData()
//            }
            
            
    }
    
    @ViewBuilder
    var view: some View {
        ScrollView{
            ForEach(pageBuilder.pageComponents, id: \.self) { component in
                pageBuilder.buildComponent(variant: component.variant)
            }
        }
    }
}

@available(iOS 15.0, *)
struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
