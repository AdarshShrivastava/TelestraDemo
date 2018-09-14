
import UIKit
import ReachabilitySwift
import SystemConfiguration

/// Protocol for listenig network status change
public protocol NetworkStatusListener : class {
    func networkStatusDidChange(status: Reachability.NetworkStatus)
}

public class ReachibilityManager: NSObject {
    
    static  let shared = ReachibilityManager()
    
    var listeners = [NetworkStatusListener]()
    
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
        
        // Sending message to the delegate
        for listener in listeners {
            listener.networkStatusDidChange(status: reachability.currentReachabilityStatus)
        }
    }
    
    
    /// Adds a new listener to the listeners array
    func addListener(listener: NetworkStatusListener){
        listeners.append(listener)
    }
    
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
    
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
}
