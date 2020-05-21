//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation
import RxSwift
import MiceDomain

public class PlayersManager: PlayersRepository  {
    
    public init() {
        
    }
    
    public func getPlayersNames() -> Single<(String, String)> {
        return Single.create { singleEvent in
            singleEvent(.success(UserDefaultsManager.instance.getPlayersNames()))
            return Disposables.create()
        }
    }
    
    public func savePlayersNames(for names: (String, String)) -> Observable<Bool> {
        return Observable.create { observer in
            UserDefaultsManager.instance.savePlayersNames(names: names)
            observer.onCompleted()
            return Disposables.create()
        }
    }
}
