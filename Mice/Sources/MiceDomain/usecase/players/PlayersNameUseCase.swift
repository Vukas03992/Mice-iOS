//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation
import RxSwift

public class PlayersNameUseCase {
    
    let playersRepository: PlayersRepository
    
    public init(_ repository: PlayersRepository) {
        playersRepository = repository
    }
    
    public func get() -> Single<(String, String)>{
        return playersRepository.getPlayersNames()
    }
    
    public func save(playerOne: String, playerTwo: String) -> Observable<Bool> {
        return playersRepository.savePlayersNames(for: (playerOne, playerTwo))
    }
}
