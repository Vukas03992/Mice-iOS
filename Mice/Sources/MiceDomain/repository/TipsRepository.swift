//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation
import RxSwift

protocol TipsRepository{
    func getTipsPermission() -> Observable<Bool>
    func saveTipsPermission(_ permitted: Bool) -> Observable<Void>
}
