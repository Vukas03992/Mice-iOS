//
//  PlayersViewModel.swift
//  MiceGame
//
//  Created by Vukašin Prvulović on 12/10/19.
//  Copyright © 2019 Vukašin Prvulović. All rights reserved.
//

import Foundation
import MiceDomain
import RxSwift
import RxRelay
import Swinject

class PlayersViewModel: BaseViewModel {
    
    let playersNamesRelay: PublishSubject<(String, String)> = PublishSubject()
    
    var playersNameUseCase: PlayersNameUseCase?
    
    func viewWillAppear() {
        playersNameUseCase?.get()
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
        .subscribe(onSuccess: { names in
            self.playersNamesRelay.on(.next(names))
        }, onError: { error in
            
            }).disposed(by: disposeBag)
    }
    
    func saveNames(playerOne: String?, playerTwo: String?){
        guard playerOne != nil && playerTwo != nil else { return }
        if !playerOne!.isEmpty && !playerTwo!.isEmpty {
            playersNameUseCase?.save(playerOne: playerOne!, playerTwo: playerTwo!)
            .subscribeOn(SerialDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe {
                    
            }.disposed(by: disposeBag)
        }
    }
}

func registerPlayersViewModel(container: Container){
    container.register(PlayersViewModel.self) { r in
        let playersViewModel = PlayersViewModel()
        playersViewModel.playersNameUseCase = r.resolve(PlayersNameUseCase.self)
        return playersViewModel
    }
}
