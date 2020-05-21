//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class SecondNeighborAddHandler: AddMiceBaseHandler {
    
    override func handle() {
        if mice.row == -1 && mice.col == -1 {
            return
        }
        if mice.row != -1 && !mice.hasRowMice {
            for field in nextField.neighbors {
                if field.row == mice.row && field.col != nextField.col && field.fieldState.rawValue == playerState.rawValue {
                    mice.hasRowMice = true
                    break
                }else{
                    mice.hasRowMice = false
                }
            }
        }
        if mice.col != -1 && !mice.hasColMice {
            for field in nextField.neighbors {
                if field.col == mice.col && field.row != nextField.row && field.fieldState.rawValue == playerState.rawValue {
                    mice.hasColMice = true
                    break
                }else{
                    mice.hasColMice = false
                }
            }
        }
    }
}
