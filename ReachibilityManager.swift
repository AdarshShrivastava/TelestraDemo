//
//  ReachibilityManager.swift
//  TelestraTest
//
//  Created by Adarsh Shrivastava on 10/09/18.
//  Copyright © 2018 Adarsh Shrivastava. All rights reserved.
//

import UIKit
import ReachabilitySwift

public class ReachibilityManager: NSObject {
    
    static  let shared = ReachibilityManager()
    
    var reachabilityStatus: Reachability.NetworkStatus = .notReachable
    
    var isNetworkAvailable : Bool {
        return reachabilityStatus != .notReachable
    }
    
    let reachability = Reachability()!
    
    
    func reachabilityChanged(notification: Notification) {
        let reachability = notification.object as! Reachability
        switch reachability.currentReachabilityStatus {
        case .notReachable:
            debugPrint("Network became unreachable")
        case .reachableViaWiFi:
            debugPrint("Network reachable through WiFi")
        case .reachableViaWWAN:
            debugPrint("Network reachable through Cellular Data")
        }
    }
    
    
    /// Starts monitoring the network availability status
    func startMonitoring() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.reachabilityChanged),
                                               name: ReachabilityChangedNotification,
                                               object: reachability)
        do{
            try reachability.startNotifier()
        } catch {
            debugPrint("Could not start reachability notifier")
        }
    }
    
    /// Stops monitoring the network availability status
    func stopMonitoring(){
        reachability.stopNotifier()
        NotificationCenter.default.removeObserver(self,
                                                  name: ReachabilityChangedNotification,
                                                  object: reachability)
    }

}
