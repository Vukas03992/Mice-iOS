//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class Mice {
    var row: Int
    var col: Int
    var hasRowMice: Bool
    var hasColMice: Bool
    
    init(_ row: Int, _ col: Int, _ hasColMice: Bool, _ hasRowMice: Bool) {
        self.row = row
        self.col = col
        self.hasRowMice = hasRowMice
        self.hasColMice = hasColMice
    }
}
