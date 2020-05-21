//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation
import RxSwift

public class GetLastGameUseCase {
    
    let gameSnapshotRepository: GameSnapshotRepository
    
    public init(_ gameSnapshotRepository: GameSnapshotRepository) {
        self.gameSnapshotRepository = gameSnapshotRepository
    }
    
    public func get() -> Single<Game?> {
        return gameSnapshotRepository.getLastGameSnapshot()
    }
    
    public func canContinue() -> Single<Bool> {
        return gameSnapshotRepository.getLastGameSnapshot()
            .map{ game in
                return game != nil
        }
    }
}
