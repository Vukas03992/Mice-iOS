//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class WinnerHandler: Handler {
    
    override init(game: Game, previousField: String, nextField: String, gameSnapshotRepository: GameSnapshotRepository) {
        super.init(game: game, previousField: previousField, nextField: nextField, gameSnapshotRepository: gameSnapshotRepository)
    }
    
    override func handle() -> Game {
        if game.gameState.setState == .setOver {
            let winnerHandler = WinnerBaseHandler(game: game)
            winnerHandler.addHandler(WinnerByNumberHandler(game: game))
            winnerHandler.addHandler(WinnerByMoveHandler(game: game))
            winnerHandler.handle()
        }
        gameSnapshotRepository.addSnapshot(game)
        return super.handle()
    }
}
