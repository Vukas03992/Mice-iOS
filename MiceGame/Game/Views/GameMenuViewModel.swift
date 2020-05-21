//
//  GameMenuViewModel.swift
//  MiceGame
//
//  Created by Vukašin Prvulović on 12/14/19.
//  Copyright © 2019 Vukašin Prvulović. All rights reserved.
//

import Foundation
import MiceDomain
import RxSwift
import Swinject

class GameMenuViewModel {
    
    let musicUseCase: MusicUseCase
    let soundUseCase: SoundUseCase
    
    var musicAndSoundManager: MusicAndSoundManager?
    
    init(_ music: MusicUseCase, _ sound: SoundUseCase) {
        musicUseCase = music
        soundUseCase = sound
    }
    
    func handleMusic() -> Bool {
        let musicPermission = !musicUseCase.get()
        if let musicManager = musicAndSoundManager {
            if musicPermission {
                musicManager.playerMusic(file: musicUseCase.getContentPath())
            }else{
                musicManager.stopMusic()
            }
        }
        musicUseCase.save(musicPermission)
        return musicPermission
    }
    
    func handleSound() -> Bool {
        let soundPermission = !soundUseCase.get()
        if soundPermission {
        musicAndSoundManager?.prepareSoundEffects(takeToken: soundUseCase.getContentPath(.takeToken), putToken: soundUseCase.getContentPath(.putToken), miceMade: soundUseCase.getContentPath(.miceSound))
        }
        soundUseCase.save(soundPermission)
        return soundPermission
    }
    
    func getPermissions() -> (Bool, Bool) {
        return (musicUseCase.get(), soundUseCase.get())
    }
}

func registerGameMenuViewModel(container: Container){
    container.register(GameMenuViewModel.self) { r in
        let viewModel = GameMenuViewModel(r.resolve(MusicUseCase.self)!, r.resolve(SoundUseCase.self)!)
        viewModel.musicAndSoundManager = r.resolve(MusicAndSoundManager.self)
        return viewModel
    }
}
