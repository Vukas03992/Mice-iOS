//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class MoveHandler: Handler {
    
    override func handle() -> Game {
        
        //take reference of current player
        let playerState = game.gameState.nextPlayerState
        //candidate to be filled
        let nextFieldState: FieldState
        
        if playerState.rawValue == 1 {
            nextFieldState = .playerOne
        }else{
            nextFieldState = .playerTwo
        }
        
        if game.gameState.setState == .stillSet {
            let nextFieldObject = game.fields[nextField]
            if nextFieldObject!.fieldState == .emptyField {
                nextFieldObject!.fieldState = nextFieldState
            }
        }else{
            let previousFieldObject: Field = game.fields[previousField]!
            let nextFieldObject: Field = game.fields[nextField]!
            
            if previousFieldObject.fieldState == nextFieldState {
                for neighbor in previousFieldObject.neighbors {
                    if neighbor.id == nextFieldObject.id {
                        if neighbor.fieldState == .emptyField {
                            if previousFieldObject.miceState == .inMice {
                                game.fields[previousField]!.miceState = .noMice
                                let mice = Mice(-1,-1,false,false)
                                let deleteHandler = DeleteMiceBaseHandler(mice, game.fields[previousField]!, game.fields[nextField]!)
                                deleteHandler.addHandler(FirstNeighborDeleteHandler(mice, game.fields[previousField]!, game.fields[nextField]!))
                                deleteHandler.addHandler(SecondNeighborDEleteHandler(mice, game.fields[previousField]!, game.fields[nextField]!))
                                deleteHandler.handle()
                            }
                            previousFieldObject.fieldState = .emptyField
                            nextFieldObject.fieldState = nextFieldState
                        }
                    }
                }
            }
        }
        if game.fields[nextField]!.fieldState != nextFieldState {
            return game
        }else if game.gameState.setState == .setOver && game.fields[previousField]!.fieldState == nextFieldState {
            return game
        }
        return super.handle()
    }
}
