//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation
import RxSwift

public protocol FieldsRepository{
    func getFields() -> Single<[String:Field]>
    func getFieldsTags() -> Single<Array<String>>
}
