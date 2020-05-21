//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class EatHandler: Handler {
    
    override func handle() -> Game {
        
        if game.gameState.miceMadeState == .miceIsMade {
            if previousField == nextField {
                let pressedFieldState = game.fields[nextField]!.fieldState
                let nextPlayerState = game.gameState.nextPlayerState
                
                if pressedFieldState.rawValue != 0 && pressedFieldState.rawValue != nextPlayerState.rawValue {
                    if game.fields[nextField]!.miceState == .noMice {
                        game.fields[nextField]!.fieldState = .emptyField
                        game.gameState = game.gameState.copy(newMiceMadeState: .miceIsNotMade)
                        if nextPlayerState == .playerOne {
                            game.gameState = game.gameState.copy(newNextPlayerState: .playerTwo)
                        }else{
                            game.gameState = game.gameState.copy(newNextPlayerState: .playerOne)
                        }
                        game.numberOfPlayers = game.numberOfPlayers - 1
                        if game.numberOfPlayers <= 0 {
                            game.gameState = game.gameState.copy(newSetState: .setOver)
                            let winnerHandler = WinnerBaseHandler(game: game)
                            winnerHandler.addHandler(WinnerByNumberHandler(game: game))
                            winnerHandler.addHandler(WinnerByMoveHandler(game: game))
                            winnerHandler.handle()
                        }
                        gameSnapshotRepository.addSnapshot(game)
                    }
                }
                
            }
            return game
        }else{
            if previousField == nextField {
                return game
            }
            return super.handle()
        }
    }
}
