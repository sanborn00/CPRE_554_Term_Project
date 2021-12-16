//
//  SecondView.swift
//  Client
//
//  Created by Shuangquan on 12/11/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct SecondView: View {
    
    @StateObject var pageBuilder: PageBuilder = PageBuilder()

    var body: some View {
        Text("Hello, World!")
    }
}

@available(iOS 15.0, *)
struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
