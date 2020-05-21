//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation
import MiceDomain

public class MediaPlayerManager: MediaPlayerRepository {
    
    public init() {
        
    }
    
    public func getMusicPermission() -> Bool {
        return UserDefaultsManager.instance.getMusicPermission()
    }
    
    public func saveMusicPermission(_ permitted: Bool) {
        UserDefaultsManager.instance.saveMusicPermission(permitted)
    }
    
    public func getMusicContentFilePath() -> String {
        return "background_music.mp3"
    }
    
    public func getSoundPermission() -> Bool {
        return UserDefaultsManager.instance.getSoundPermission()
    }
    
    public func saveSoundPermission(_ permitted: Bool) {
        UserDefaultsManager.instance.saveSoundPermission(permitted)
    }
    
    public func getSoundContentFilePath(forType: SoundUseCase.SoundType) -> String {
        switch forType {
        case .takeToken:
            return "take_token_sound_effect.mp3"
        case .putToken:
            return "put_token_sound_effect.mp3"
        case .miceSound:
            return "mice_sound_effect.mp3"
        }
    }
}
