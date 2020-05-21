//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation
import RxSwift

public class UndoGameUseCase {
    
    let gameSnapshotRepository: GameSnapshotRepository
    
    public init(_ gameSnapshotRepository: GameSnapshotRepository) {
        self.gameSnapshotRepository = gameSnapshotRepository
    }
    
    public func undo() -> Single<Game> {
        return gameSnapshotRepository.undo()
    }
}
