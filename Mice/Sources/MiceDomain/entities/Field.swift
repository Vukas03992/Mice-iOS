//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

public class Field{
    public var id: String = ""
    public var col: Int = 0
    public var row: Int = 0
    public var fieldState: FieldState = .emptyField
    public var miceState: MiceState = .noMice
    public var neighbors: [Field] = []
    public var fieldType: FieldType = .primary
    
    public init(){
        
    }
    
    func copy() -> Field {
        let field =  Field()
        field.id = self.id
        field.col = self.col
        field.row = self.row
        field.fieldState = self.fieldState
        field.fieldType = self.fieldType
        field.miceState = self.miceState
        return field
    }
}
