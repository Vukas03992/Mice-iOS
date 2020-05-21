//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

public protocol MediaPlayerRepository{
    func getMusicPermission() -> Bool
    func saveMusicPermission(_ permitted: Bool) -> Void
    func getMusicContentFilePath() -> String
    
    func getSoundPermission() -> Bool
    func saveSoundPermission(_ permitted: Bool) -> Void
    func getSoundContentFilePath(forType: SoundUseCase.SoundType) -> String
}
