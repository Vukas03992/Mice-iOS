//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class FirstNeighborDeleteHandler: DeleteMiceBaseHandler {
    
    override func handle() {
        switch previousField.fieldType {
        case .primary, .secondary:
            check()
        case .ternary:
            check()
            return
        }
        super.handle()
    }
    
    private func check(){
        for firstNeighbor in previousField.neighbors {
            if firstNeighbor.miceState == .inMice && firstNeighbor.fieldState == previousField.fieldState {
                if firstNeighbor.row == previousField.row && firstNeighbor.row != nextField.row {
                    mice.hasRowMice = true
                    mice.hasColMice = false
                    checkNeighbor(firstNeighbor)
                }
                if firstNeighbor.col == previousField.col && firstNeighbor.col != nextField.col {
                    mice.hasRowMice = false
                    mice.hasColMice = true
                    checkNeighbor(firstNeighbor)
                }
            }
        }
    }
    
    private func checkNeighbor(_ firstNeighbor: Field){
        if mice.hasRowMice {
            for field in firstNeighbor.neighbors {
                if field.row != previousField.row && field.col == firstNeighbor.col {
                    if field.miceState == .noMice || (field.miceState == .inMice && field.fieldState != previousField.fieldState){
                        firstNeighbor.miceState = .noMice
                    }
                }
            }
        }else{
            for field in firstNeighbor.neighbors {
                if field.col != previousField.col && field.row == firstNeighbor.row {
                    if field.miceState == .noMice || (field.miceState == .inMice && field.fieldState != previousField.fieldState) {
                        firstNeighbor.miceState = .noMice
                    }
                }
            }
        }
    }
}
