//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class MiceHandler: Handler {
    
    override func handle() -> Game {
        //block of checking for mice
        let mice = Mice(-1, -1, false, false)
        
        guard let nextField = game.fields[nextField] else { return super.handle() }
        
        let addHandler = AddMiceBaseHandler(mice, nextField, game.gameState.nextPlayerState)
        addHandler.addHandler(FirstNeighborAddHandler(mice, nextField, game.gameState.nextPlayerState))
        addHandler.addHandler(SecondNeighborAddHandler(mice, nextField, game.gameState.nextPlayerState))
        
        addHandler.handle()
        
        //check if mice is made
        if mice.hasRowMice {
            game.fields[self.nextField]!.miceState = .inMice
            for miceField in game.fields[self.nextField]!.neighbors {
                if miceField.row == game.fields[self.nextField]!.row {
                    miceField.miceState = .inMice
                    for miceField1 in miceField.neighbors {
                        if miceField1.row == game.fields[self.nextField]!.row {
                            miceField1.miceState = .inMice
                        }
                    }
                }
            }
            game.gameState = game.gameState.copy(newMiceMadeState: .miceIsMade)
        }
        if mice.hasColMice {
            game.fields[self.nextField]!.miceState = .inMice
            for miceField in game.fields[self.nextField]!.neighbors {
                if miceField.col == game.fields[self.nextField]!.col {
                    miceField.miceState = .inMice
                    for miceField1 in miceField.neighbors {
                        if miceField1.col == game.fields[self.nextField]!.col {
                            miceField1.miceState = .inMice
                        }
                    }
                }
            }
            game.gameState = game.gameState.copy(newMiceMadeState: .miceIsMade)
        }
        return super.handle()
    }
}
