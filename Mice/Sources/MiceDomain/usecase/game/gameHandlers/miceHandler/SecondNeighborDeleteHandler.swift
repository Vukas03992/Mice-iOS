//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class SecondNeighborDEleteHandler: DeleteMiceBaseHandler {
    
    override func handle() {
        if mice.hasRowMice {
            for field in previousField.neighbors {
                if field.row == previousField.row {
                    for secondNeighbor in field.neighbors {
                        if secondNeighbor.col != previousField.col && secondNeighbor.row == previousField.row {
                            for neighborOfSecondNeighbor in secondNeighbor.neighbors {
                                if neighborOfSecondNeighbor.row != previousField.row && (neighborOfSecondNeighbor.miceState == .noMice || (neighborOfSecondNeighbor.miceState == .inMice && neighborOfSecondNeighbor.fieldState != secondNeighbor.fieldState)){
                                    secondNeighbor.miceState = .noMice
                                }
                                if neighborOfSecondNeighbor.row != previousField.row && neighborOfSecondNeighbor.miceState == .inMice && neighborOfSecondNeighbor.fieldState == previousField.fieldState {
                                    for fieldX in neighborOfSecondNeighbor.neighbors {
                                        if fieldX.col == secondNeighbor.col && (fieldX.miceState == .noMice || (fieldX.miceState == .inMice && fieldX.fieldState != secondNeighbor.fieldState)){
                                            secondNeighbor.miceState = .noMice
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        if mice.hasColMice {
            for field in previousField.neighbors {
                if field.col == previousField.col {
                    for secondNeighbor in field.neighbors {
                        if secondNeighbor.row != previousField.row && secondNeighbor.col == previousField.col {
                            for neighborOfSecondNeighbor in secondNeighbor.neighbors {
                                if neighborOfSecondNeighbor.col != previousField.col && (neighborOfSecondNeighbor.miceState == .noMice || (neighborOfSecondNeighbor.miceState == .inMice && neighborOfSecondNeighbor.fieldState != previousField.fieldState)){
                                    secondNeighbor.miceState = .noMice
                                }
                                if neighborOfSecondNeighbor.col != previousField.col && neighborOfSecondNeighbor.miceState == .inMice && neighborOfSecondNeighbor.fieldState == previousField.fieldState {
                                    for fieldX in neighborOfSecondNeighbor.neighbors {
                                        if fieldX.row == secondNeighbor.row && (fieldX.miceState == .noMice || (fieldX.miceState == .inMice && fieldX.fieldState != secondNeighbor.fieldState)){
                                            secondNeighbor.miceState = .noMice
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        super.handle()
    }
}
