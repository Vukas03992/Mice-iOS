//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class Handler {
    let game: Game
    var next: Handler? = nil
    let previousField: String
    let nextField: String
    let gameSnapshotRepository: GameSnapshotRepository
    
    init(game: Game, previousField: String, nextField: String, gameSnapshotRepository: GameSnapshotRepository) {
        self.game = game
        self.previousField = previousField
        self.nextField = nextField
        self.gameSnapshotRepository = gameSnapshotRepository
    }
    
    func handle() -> Game{
        if let next = self.next {
            return next.handle()
        }else{
            return self.game
        }
    }
    
    func add(_ nextHandler: Handler) {
        if let next = self.next {
            next.add(nextHandler)
        }else{
            self.next = nextHandler
        }
    }
}
