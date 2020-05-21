//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/9/19.
//

import Foundation
import MiceDomain
import RxSwift

public class FieldsManager: FieldsRepository {
    
    public init() {}
    
    public func getFields() -> Single<[String : Field]> {
        return Single.create(subscribe: { singleEvent in
            singleEvent(.success(self.readFields()))
            return Disposables.create()
        })
    }
    
    public func getFieldsTags() -> Single<Array<String>> {
        return Single<Array<String>>.create(subscribe: { singleEvent in
            singleEvent(.success(self.readFieldsTags()))
            return Disposables.create()
        })
    }
    
    private func readFieldsTags() -> [String] {
        let url = Bundle.main.url(forResource: "fieldsTags", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let fieldsTags = try! JSONDecoder().decode([String].self, from: data)
        return fieldsTags
    }
    
    private func readFields() -> [String:Field] {
        let url = Bundle.main.url(forResource: "fields", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let fields = try! JSONDecoder().decode([FieldModel].self, from: data)
        
        var fieldMap = [String:Field]()
        
        for fieldModel in fields {
            let field = Field()
            field.id = "\(fieldModel.row)_\(fieldModel.col)"
            field.row = fieldModel.row
            field.col = fieldModel.col
            switch fieldModel.type {
                case "primary": field.fieldType = .primary
                case "secondary": field.fieldType = .secondary
                case "ternary": field.fieldType = .ternary
            default: field.fieldType = .primary
            }
            fieldMap[field.id] = field
        }
        
        for fieldModel in fields {
            let id = "\(fieldModel.row)_\(fieldModel.col)"
            var neighbors = [Field]()
            for neighbor in fieldModel.neighborhood {
                neighbors.append(fieldMap[neighbor]!)
            }
            fieldMap[id]!.neighbors = neighbors
        }
        
        return fieldMap
    }
}
