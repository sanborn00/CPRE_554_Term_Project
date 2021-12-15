//
//  FirstView.swift
//  Client
//
//  Created by Shuangquan on 12/11/21.
//

import SwiftUI
import Combine


@available(iOS 15.0, *)
struct FirstView: View {
    
    @StateObject var pageBuilder: PageBuilder = PageBuilder()
        
    var body: some View {
        pageBuilder.view
    }
}

@available(iOS 15.0, *)
struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        FirstView()
    }
}
