//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation
import UIKit

class UserDefaultsManager {
    
    static let instance = UserDefaultsManager()
    private let userDefaults = UserDefaults.standard
    
    func saveSoundPermission(_ permission: Bool) {
        userDefaults.set(permission, forKey: soundPermissionKey)
    }
    
    func getSoundPermission() -> Bool {
        if userDefaults.object(forKey: soundPermissionKey) == nil {
            return true
        }
        return userDefaults.bool(forKey: soundPermissionKey)
    }
    
    func saveMusicPermission(_ permission: Bool) {
        userDefaults.set(permission, forKey: musicPermissionKey)
    }
    
    func getMusicPermission() -> Bool {
        if userDefaults.object(forKey: musicPermissionKey) == nil {
            return true
        }
        return userDefaults.bool(forKey: musicPermissionKey)
    }
    
    func savePlayersNames(names: (String, String)) {
        userDefaults.set(names.0, forKey: playerOneNameKey)
        userDefaults.set(names.1, forKey: playerTwoNameKey)
    }
    
    func getPlayersNames() -> (String, String) {
        return (userDefaults.string(forKey: playerOneNameKey) ?? "playerOne", userDefaults.string(forKey: playerTwoNameKey) ?? "playerTwo")
    }
    
    private let soundPermissionKey = "sound"
    private let musicPermissionKey = "music"
    private let playerOneNameKey = "playerOne"
    private let playerTwoNameKey = "playerTwo"
}
