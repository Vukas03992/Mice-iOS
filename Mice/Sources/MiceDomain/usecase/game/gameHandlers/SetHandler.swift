//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class SetHandler: Handler {
    
    override func handle() -> Game {
        if game.numberOfPlayers <= 0 {
            game.gameState = game.gameState.copy(newSetState: .setOver)
        }
        return super.handle()
    }
}
