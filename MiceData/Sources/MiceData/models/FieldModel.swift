//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/9/19.
//

import Foundation

class FieldModel: Decodable {
    
    let row: Int
    let col: Int
    let neighborhood: [String]
    let type: String
    
    init(_ row: Int, _ col: Int, _ neighborhood: [String], _ type: String) {
        self.row = row
        self.col = col
        self.neighborhood = neighborhood
        self.type = type
    }
}
