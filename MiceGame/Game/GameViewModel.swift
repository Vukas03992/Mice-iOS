//
//  GameViewModel.swift
//  MiceGame
//
//  Created by Vukašin Prvulović on 12/14/19.
//  Copyright © 2019 Vukašin Prvulović. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MiceDomain
import Swinject

class GameViewModel: BaseViewModel {
    
    var names: (String, String)?
    var game: Game? {
        didSet {
            gameBehavioralRelay.accept(game)
        }
    }
    let gameBehavioralRelay = BehaviorRelay<Game?>(value: nil)
    var previousField: String?
    var continueGame: Bool = false
    
    let playGameUseCase: PlayGameUseCase
    let undoGameUseCase: UndoGameUseCase
    let readFieldTagsUseCase: ReadFieldTagsUseCase
    let playersNameUseCase: PlayersNameUseCase
    let soundUseCase: SoundUseCase
    let getLastGameUseCase: GetLastGameUseCase
    
    var musicAndSoundManager: MusicAndSoundManager?
    
    init(_ play: PlayGameUseCase, _ undo: UndoGameUseCase, _ readFieldTag: ReadFieldTagsUseCase, _ players: PlayersNameUseCase, _ sound: SoundUseCase, _ lastGame: GetLastGameUseCase) {
        self.playGameUseCase = play
        self.undoGameUseCase = undo
        self.readFieldTagsUseCase = readFieldTag
        self.playersNameUseCase = players
        self.soundUseCase = sound
        self.getLastGameUseCase = lastGame
    }
    
    func viewDidLoad() {
        print("\(continueGame)")
        if continueGame {
            playersNameUseCase.get()
            .flatMap({ names in
                self.names = names
                return self.getLastGameUseCase.get()
            })
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { game in
                self.game = game
            }).disposed(by: disposeBag)
        }else{
            playersNameUseCase.get()
                .flatMap({ names in
                    self.names = names
                    return self.playGameUseCase.play(game: nil, previousField: "", nextField: "")
                })
                .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
                .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { game in
                self.game = game
            }).disposed(by: disposeBag)
        }
        if soundUseCase.get() {
            musicAndSoundManager?.prepareSoundEffects(takeToken: soundUseCase.getContentPath(.takeToken), putToken: soundUseCase.getContentPath(.putToken), miceMade: soundUseCase.getContentPath(.miceSound))
        }
    }
    
    func play(nextField: String) {
        playGameUseCase.play(game: game!, previousField: previousField ?? "", nextField: nextField)
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
        .subscribe(onSuccess: { game in
            self.previousField = ""
            self.game = game
        }).disposed(by: disposeBag)
    }
    
    func undo() {
        undoGameUseCase.undo()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
        .subscribe(onSuccess: { game in
            self.previousField = ""
            self.game = game
        }).disposed(by: disposeBag)
    }
    
    func getFieldTags() -> Single<Array<String>> {
        return readFieldTagsUseCase.read()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
    }
    
    func putTokenPlay() {
        if soundUseCase.get() {
        musicAndSoundManager?.putTokenPlay()
        }
    }
    
    func takeTokenPlay() {
        if soundUseCase.get() {
        musicAndSoundManager?.takeTokenPlay()
        }
    }
    
    func miceMadePlay() {
        if soundUseCase.get() {
        musicAndSoundManager?.miceMadePlay()
        }
    }
}

func registerGameViewModel(container: Container) {
    container.register(GameViewModel.self) { r in
        let vm = GameViewModel(r.resolve(PlayGameUseCase.self)!, r.resolve(UndoGameUseCase.self)!, r.resolve(ReadFieldTagsUseCase.self)!, r.resolve(PlayersNameUseCase.self)!, r.resolve(SoundUseCase.self)!, r.resolve(GetLastGameUseCase.self)!)
        vm.musicAndSoundManager = r.resolve(MusicAndSoundManager.self)
        return vm
    }
}
