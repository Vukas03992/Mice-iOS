//
//  MenuViewModel.swift
//  MiceGame
//
//  Created by Vukašin Prvulović on 12/9/19.
//  Copyright © 2019 Vukašin Prvulović. All rights reserved.
//

import Foundation
import MiceDomain
import Swinject
import RxSwift

class MenuViewModel: BaseViewModel {
    
    var canContinue = false
    
    let musicUseCase: MusicUseCase
    let getLastGameUseCase: GetLastGameUseCase
    
    var musicAndSoundManager: MusicAndSoundManager?
    
    init(_ musicUseCase: MusicUseCase, _ lastGame: GetLastGameUseCase) {
        self.musicUseCase = musicUseCase
        self.getLastGameUseCase = lastGame
    }
    
    func viewDidLoad() {
        if musicUseCase.get() {
            musicAndSoundManager?.playerMusic(file: musicUseCase.getContentPath())
        }
    }
    
    func viewWillAppear() {
        getLastGameUseCase.canContinue()
        .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
        .observeOn(MainScheduler.instance)
        .subscribe(onSuccess: { can in
            self.canContinue = can
            }).disposed(by: disposeBag)
    }
}

func registerMenuViewModel(container: Container) {
    container.register(MenuViewModel.self) { r in
        let menuViewModel = MenuViewModel(r.resolve(MusicUseCase.self)!, r.resolve(GetLastGameUseCase.self)!)
        menuViewModel.musicAndSoundManager = r.resolve(MusicAndSoundManager.self)
        return menuViewModel
    }
}
