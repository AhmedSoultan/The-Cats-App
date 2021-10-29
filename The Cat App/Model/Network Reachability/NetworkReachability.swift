//
//  NetworkReachability.swift
//  The Cat App
//
//  Created by ahmed sultan on 29/10/2021.
//

import Foundation
import SystemConfiguration

class NetworkReachability: ObservableObject {
    
    //MARK:- Properties
    
    static var shared = NetworkReachability()
    @Published private(set) var reachable: Bool = false
    private var reachability = SCNetworkReachabilityCreateWithName(nil, "www.designcode.io")

    //MARK:- Initializer
    
    private init() {
        self.reachable = checkConnection()
    }

    //MARK:- Custom actions
    
    private func isNetworkReachable(with flags: SCNetworkReachabilityFlags) -> Bool {
        let isReachable = flags.contains(.reachable)
        let connectionRequired = flags.contains(.connectionRequired)
        let canConnectAutomatically = flags.contains(.connectionOnDemand) || flags.contains(.connectionOnTraffic)
        let canConnectWithoutIntervention = canConnectAutomatically && !flags.contains(.interventionRequired)
        return isReachable && (!connectionRequired || canConnectWithoutIntervention)
    }

    func checkConnection() -> Bool {
        var flags = SCNetworkReachabilityFlags()
        SCNetworkReachabilityGetFlags(reachability!, &flags)
        return isNetworkReachable(with: flags)
    }
}
