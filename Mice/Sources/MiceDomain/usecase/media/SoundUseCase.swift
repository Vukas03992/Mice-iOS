//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

public class SoundUseCase {
    
    public enum SoundType{
        case putToken
        case takeToken
        case miceSound
    }
    
    let mediaPlayerRepository: MediaPlayerRepository
    
    public init(_ mediaPlayerRepository: MediaPlayerRepository) {
        self.mediaPlayerRepository = mediaPlayerRepository
    }
    
    public func get() -> Bool {
        return mediaPlayerRepository.getSoundPermission()
    }
    
    public func save(_ permission: Bool) {
        mediaPlayerRepository.saveSoundPermission(permission)
    }
    
    public func getContentPath(_ type: SoundType) -> String {
        return mediaPlayerRepository.getSoundContentFilePath(forType: type)
    }
}
