//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation
import RxSwift

public class PlayGameUseCase {
    
    let fieldsRepository: FieldsRepository
    let gameSnapshotRepository: GameSnapshotRepository
    
    public init(_ fieldsRepository: FieldsRepository, _ gameSnapshotRepository: GameSnapshotRepository) {
        self.fieldsRepository = fieldsRepository
        self.gameSnapshotRepository = gameSnapshotRepository
    }
    
    public func play(game: Game?, previousField: String, nextField: String) -> Single<Game?> {
        if game == nil {
            return fieldsRepository.getFields()
                .map { fields in
                    self.gameSnapshotRepository.clearGameSnapshots()
                    return Game(fields, GameState(nextPlayerState: .playerOne, miceMadeState: .miceIsNotMade, setState: .stillSet, winnerState: .noWinner), 18)
                }
        }else{
            return Single<Game?>.create { singleEvent in
                let handler = Handler(game: game!, previousField: previousField, nextField: nextField, gameSnapshotRepository: self.gameSnapshotRepository)
                handler.add(EatHandler(game: game!, previousField: previousField, nextField: nextField, gameSnapshotRepository: self.gameSnapshotRepository))
                handler.add(MoveHandler(game: game!, previousField: previousField, nextField: nextField, gameSnapshotRepository: self.gameSnapshotRepository))
                handler.add(MiceHandler(game: game!, previousField: previousField, nextField: nextField, gameSnapshotRepository: self.gameSnapshotRepository))
                handler.add(TurnHandler(game: game!, previousField: previousField, nextField: nextField, gameSnapshotRepository: self.gameSnapshotRepository))
                handler.add(SetHandler(game: game!, previousField: previousField, nextField: nextField, gameSnapshotRepository: self.gameSnapshotRepository))
                handler.add(WinnerHandler(game: game!, previousField: previousField, nextField: nextField, gameSnapshotRepository: self.gameSnapshotRepository))
                
                singleEvent(.success(handler.handle()))
                
                return Disposables.create()
            }
        }
    }
}
