//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

public class MusicUseCase {
    
    let mediaPlayerRepository: MediaPlayerRepository
    
    public init(_ mediaPlayerRepository: MediaPlayerRepository) {
        self.mediaPlayerRepository = mediaPlayerRepository
    }
    
    public func get() -> Bool {
        return mediaPlayerRepository.getMusicPermission()
    }
    
    public func save(_ permission: Bool) {
        mediaPlayerRepository.saveMusicPermission(permission)
    }
    
    public func getContentPath() -> String {
        return mediaPlayerRepository.getMusicContentFilePath()
    }
}
