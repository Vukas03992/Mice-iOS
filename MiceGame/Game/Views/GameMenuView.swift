//
//  GameMenuView.swift
//  Mice
//
//  Created by Vukašin Prvulović on 12/4/19.
//  Copyright © 2019 Vukašin Prvulović. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class GameMenuView: ViewWithNib {
    
    @IBOutlet weak var music: UIImageView!
    @IBOutlet weak var sound: UIImageView!
    
    @IBOutlet var exitTapGesture: UITapGestureRecognizer!
    @IBOutlet var soundTapGesture: UITapGestureRecognizer!
    @IBOutlet var musicTapGesture: UITapGestureRecognizer!
    @IBOutlet var menuLongPressGesture: UILongPressGestureRecognizer!
    
    var gameMenuViewModel: GameMenuViewModel?
    
    init(_ viewModel: GameMenuViewModel, frame: CGRect) {
        gameMenuViewModel = viewModel
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func didInitNib() {
        let permissions = gameMenuViewModel!.getPermissions()
        setMusicState(permissions.0)
        setSoundState(permissions.1)
        getMusicClickEvent()
        getSoundClickEvent()
    }
    
    func getExitClickEvent() -> Signal<UITapGestureRecognizer> {
        return exitTapGesture.rx.event.asSignal()
    }
    
    func getMusicClickEvent() {
        musicTapGesture.rx.event.asSignal()
            .emit(onNext: { [weak self] gesture in
                let flag = self?.gameMenuViewModel?.handleMusic()
                self?.setMusicState(flag!)
            }).disposed(by: disposeBag)
    }
    
    func getSoundClickEvent() {
        soundTapGesture.rx.event.asSignal()
        .emit(onNext: { gesture in
            let flag = self.gameMenuViewModel?.handleSound()
            self.setSoundState(flag!)
            }).disposed(by: disposeBag)
    }
    
    func getMenuExitClickEvent() -> Signal<UILongPressGestureRecognizer> {
        return menuLongPressGesture.rx.event.asSignal()
    }
    
    func setMusicState(_ flag: Bool){
        if flag {
            music.image = #imageLiteral(resourceName: "ic_music")
        }else{
            music.image = #imageLiteral(resourceName: "ic_no_music")
        }
    }
    
    func setSoundState(_ flag: Bool){
        if flag {
            sound.image = #imageLiteral(resourceName: "ic_sound")
        }else{
            sound.image = #imageLiteral(resourceName: "ic_no_sound")
        }
    }
}

