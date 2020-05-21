//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class WinnerByNumberHandler: WinnerBaseHandler {
    
    //note: before calling this method, opponent is already set to be next
    override func handle() {
        if game.gameState.nextPlayerState == .playerOne {
            let numberOfPlayerOneTokens = getNumberOfTokens(.playerOne)
            if numberOfPlayerOneTokens <= 2 {
                game.gameState = game.gameState.copy(newWinnerState: .winnerTwo)
            }
            return
        }else {
            let numberOfPlayerTwoTokens = getNumberOfTokens(.playerTwo)
            if numberOfPlayerTwoTokens <= 2 {
                game.gameState = game.gameState.copy(newWinnerState: .winnerOne)
            }
            return
        }
    }
    
    private func getNumberOfTokens(_ fieldState: FieldState) -> Int {
        var number = 0
        for field in game.fields {
            if field.value.fieldState == fieldState {
                number += 1
            }
        }
        return number
    }
}
