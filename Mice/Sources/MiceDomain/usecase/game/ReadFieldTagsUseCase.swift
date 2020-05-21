//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation
import RxSwift

public class ReadFieldTagsUseCase {
    
    let fieldsRepository: FieldsRepository
    
    public init(_ fieldsRepository: FieldsRepository) {
        self.fieldsRepository = fieldsRepository
    }
    
    public func read() -> Single<Array<String>> {
        return fieldsRepository.getFieldsTags()
    }
}
