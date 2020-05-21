//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class WinnerByMoveHandler: WinnerBaseHandler {
    
    //note: before calling this method, opponent is already set to be next
    override func handle() {
        var canNotMove = true
        
        if game.gameState.nextPlayerState == .playerOne {
            for field in game.fields {
                if field.value.fieldState == .playerOne {
                    for neighbor in field.value.neighbors {
                        if neighbor.fieldState == .emptyField {
                            canNotMove = false
                            break
                        }
                    }
                }
            }
        }else{
            for field in game.fields {
                if field.value.fieldState == .playerTwo {
                    for neighbor in field.value.neighbors {
                        if neighbor.fieldState == .emptyField {
                            canNotMove = false
                            break
                        }
                    }
                }
            }
        }
        if canNotMove {
            if game.gameState.nextPlayerState == .playerOne {
                game.gameState = game.gameState.copy(newWinnerState: .winnerTwo)
            }else{
                game.gameState = game.gameState.copy(newWinnerState: .winnerOne)
            }
        }
        return super.handle()
    }
}
