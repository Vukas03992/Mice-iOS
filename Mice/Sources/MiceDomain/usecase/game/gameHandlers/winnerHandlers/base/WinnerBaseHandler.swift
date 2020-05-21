//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class WinnerBaseHandler {
    
    var game: Game
    var nextWinnerHandler: WinnerBaseHandler? = nil
    
    init(game: Game) {
        self.game = game
    }
    
    func addHandler(_ winnerHandler: WinnerBaseHandler) {
        if let handler = nextWinnerHandler {
            handler.addHandler(winnerHandler)
        } else {
            nextWinnerHandler = winnerHandler
        }
    }
    
    func handle() {
        if let handler = nextWinnerHandler {
            return handler.handle()
        }
    }
}
