//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

public class Game{
    public let fields: [String: Field]
    public var gameState: GameState
    public var numberOfPlayers: Int
    public var message: String? = nil
    
    init(_ fields: [String: Field], _ gameState: GameState, _ numberOfPlayers: Int) {
        self.fields = fields
        self.gameState = gameState
        self.numberOfPlayers = numberOfPlayers
    }
    
    public func copy(_ fields: [String: Field]? = nil, _ gameState: GameState? = nil, _ numberOfPlayers: Int? = nil) -> Game {
        return Game(fields ?? self.copyFields(), gameState ?? self.gameState.copy(), numberOfPlayers ?? self.numberOfPlayers)
    }
    
    public func copyFields() -> [String: Field] {
        var newFields = [String: Field]()
        for field in fields {
            newFields[field.key] = field.value.copy()
        }
        for field in fields {
            for neighbor in field.value.neighbors {
                newFields[field.key]!.neighbors.append(newFields["\(neighbor.row)_\(neighbor.col)"]!)
            }
        }
        return newFields
    }
}
