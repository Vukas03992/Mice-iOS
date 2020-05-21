//
//  MiceContainer.swift
//  MiceGame
//
//  Created by Vukašin Prvulović on 12/9/19.
//  Copyright © 2019 Vukašin Prvulović. All rights reserved.
//

import Foundation
import Swinject
import MiceData
import MiceDomain

class MiceContainer {
    
    let container = Container()
    
    init() {
        registerRepositories()
        registerMediaUseCase()
        registerUIManagers()
        registerPlayersUseCase()
        registerGameUseCase()
        
        registerMenuViewModel(container: container)
        registerPlayersViewModel(container: container)
        registerGameViewModel(container: container)
    }
    
    func registerRepositories() {
        container.register(FieldsRepository.self) { _ in
            FieldsManager()
        }.inObjectScope(ObjectScope.container)
        container.register(GameSnapshotRepository.self) { _ in
            GameSnapshotManager()
        }.inObjectScope(ObjectScope.container)
        container.register(MediaPlayerRepository.self) { _ in
            MediaPlayerManager()
        }.inObjectScope(ObjectScope.container)
        container.register(PlayersRepository.self) { _ in
            PlayersManager()
        }.inObjectScope(ObjectScope.container)
    }
    
    func registerGameUseCase() {
        container.register(GetLastGameUseCase.self) { r in
            GetLastGameUseCase(r.resolve(GameSnapshotRepository.self)!)
        }
        container.register(PlayGameUseCase.self) { r in
            PlayGameUseCase(r.resolve(FieldsRepository.self)!, r.resolve(GameSnapshotRepository.self)!)
        }
        container.register(ReadFieldTagsUseCase.self) { r in
            ReadFieldTagsUseCase(r.resolve(FieldsRepository.self)!)
        }
        container.register(UndoGameUseCase.self) { r in
            UndoGameUseCase(r.resolve(GameSnapshotRepository.self)!)
        }
    }
    
    func registerMediaUseCase(){
        container.register(MusicUseCase.self) { r in
            MusicUseCase(r.resolve(MediaPlayerRepository.self)!)
        }
        container.register(SoundUseCase.self) { r in
            SoundUseCase(r.resolve(MediaPlayerRepository.self)!)
        }
    }
    
    func registerPlayersUseCase(){
        container.register(PlayersNameUseCase.self) { r in
            PlayersNameUseCase(r.resolve(PlayersRepository.self)!)
        }
    }
    
    func registerUIManagers() {
        container.register(MusicAndSoundManager.self) { _ in
            MusicAndSoundManager()
        }.inObjectScope(ObjectScope.container)
    }
}
