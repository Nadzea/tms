//
//  RCManager.swift
//  Weather
//
//  Created by Надежда Клименко on 17.10.21.
//

import Foundation
import FirebaseRemoteConfig

enum RCValues: String {
    case useGoogleMaps
}

class RCManager {
    static let shared = RCManager()
    
    var defaultValue: [String: Any] = [RCValues.useGoogleMaps.rawValue: false]
    
    var remoteConfigConnected: (() -> ())?
    var isActivated: Bool = false
    
    init() {
        RemoteConfig.remoteConfig().setDefaults(defaultValue as? [String: NSObject])
    }
    
    func connected() { //подключаемся к RemoteConfig
        RemoteConfig.remoteConfig().fetch(withExpirationDuration: 0.0) { status, error in
            guard status == .success else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            RemoteConfig.remoteConfig().activate { result, error in
                self.isActivated = result
                
                if !result {
                    print(error?.localizedDescription ?? "")
                }
                
                self.remoteConfigConnected?()
            }
        }
    }
    
    func getBoolValue(from key: RCValues) -> Bool {
        return RemoteConfig.remoteConfig()[key.rawValue].boolValue
    }
}
