//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation
import RxSwift
import MiceDomain

public class GameSnapshotManager: GameSnapshotRepository {
    
    public init() {
        
    }
    
    private var gameSnapshots: Array<Game> = []
    
    public func addSnapshot(_ game: Game) {
        gameSnapshots.append(game.copy())
    }
    public func undo() -> Single<Game> {
        return Single.create{ singleEvent in
            if self.gameSnapshots.count == 1{
                singleEvent(.success(self.gameSnapshots[0].copy()))
            }else if self.gameSnapshots.count == 2 {
                self.gameSnapshots.remove(at: 1)
                singleEvent(.success(self.gameSnapshots[0].copy()))
            }else{
                self.gameSnapshots.remove(at: self.gameSnapshots.count - 1)
                singleEvent(.success(self.gameSnapshots[self.gameSnapshots.count - 1].copy()))
            }
            return Disposables.create()
        }
    }
    
    public func clearGameSnapshots() {
        gameSnapshots.removeAll()
    }
    
    public func getLastGameSnapshot() -> Single<Game?> {
        return Single.create{ singleEvent in
            if !self.gameSnapshots.isEmpty {
                singleEvent(.success(self.gameSnapshots[self.gameSnapshots.count - 1].copy()))
            }else{
                singleEvent(.success(nil))
            }
            return Disposables.create()
        }
    }
}
