//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation
import RxSwift

public protocol PlayersRepository{
    func getPlayersNames() -> Single<(String, String)>
    func savePlayersNames(for names: (String, String)) -> Observable<Bool>
}
