//
//  RootViewModel.swift
//  Client
//
//  Created by Shuangquan on 12/13/21.
//

import Foundation
import SwiftUI
import Combine

@available(iOS 15.0, *)
class RootViewModel: ObservableObject {
    
    
    private var timer: DispatchSourceTimer?
     var pageBuilder = PageBuilder()


    func startTimer() {
        let queue = DispatchQueue(label: Bundle.main.bundleIdentifier! + ".timer")
        timer = DispatchSource.makeTimerSource(queue: queue)
        timer!.schedule(deadline: .now(), repeating: .seconds(5))
        timer!.setEventHandler { [weak self] in
            // do whatever stuff you want on the background queue here here
            
            print("!!! ")
            
//            self?.pageBuilder.decodePageData()

            DispatchQueue.main.async {
                // update your model objects and/or UI here
                
                guard var pageComponents = self?.pageBuilder.pageComponents else{
                    return
                }
                
                guard pageComponents.count > 0 else {
                    return
                }
                
                print("!!! in \(pageComponents.count)")
                
                pageComponents[0] = ComponentDataMode(id: "1122", variant: .label, expiry: "10", itemDataModel: ItemDataModel(id: "1", text: "2222"))
                
                self?.pageBuilder.pageComponents.append(pageComponents.first!)
                
//                print("!!! end \(self?.pageBuilder.pageComponents.count)")
                
            }
        }
        timer!.resume()
    }

    func stopTimer() {
        timer?.cancel()
        timer = nil
    }
    
    
    
}
