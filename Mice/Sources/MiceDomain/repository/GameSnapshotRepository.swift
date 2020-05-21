//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation
import RxSwift

public protocol GameSnapshotRepository{
    func addSnapshot(_ game: Game) -> Void
    func undo() -> Single<Game>
    func clearGameSnapshots() -> Void
    func getLastGameSnapshot() -> Single<Game?>
}
