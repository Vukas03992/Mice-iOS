//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class TurnHandler: Handler {
    
    override func handle() -> Game {
        if game.gameState.miceMadeState == .miceIsMade {
            gameSnapshotRepository.addSnapshot(game)
            return game
        }
        let newGameState: GameState
        if game.gameState.nextPlayerState == .playerOne {
            newGameState = game.gameState.copy(newNextPlayerState: .playerTwo)
        } else {
            newGameState = game.gameState.copy(newNextPlayerState: .playerOne)
        }
        game.numberOfPlayers = game.numberOfPlayers - 1
        game.gameState = newGameState
        return super.handle()
    }
}
