//
//  ContentView.swift
//  Client
//
//  Created by Shuangquan on 9/21/21.
//

import SwiftUI

@available(iOS 15.0, *)
struct RootView: View {
    
    @StateObject var viewModel = RootViewModel()
        
    var body: some View {
        
        
        
        
        TabView {
            FirstView()
                .environmentObject(viewModel.pageBuilder)
                .tabItem{
                    Label("First View", systemImage: "1.square")
                }
                .onAppear{
                    viewModel.startTimer()
                }
                .onDisappear{
                    viewModel.stopTimer()
                }
                
            
            SecondView()
                .tabItem{
                    Label("Second View", systemImage: "2.square")
                }
                .foregroundColor(Color("red"))
            
        }
        
    }
}

@available(iOS 15.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
