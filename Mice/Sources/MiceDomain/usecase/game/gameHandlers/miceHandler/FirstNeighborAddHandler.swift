//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class FirstNeighborAddHandler: AddMiceBaseHandler {
    
    override func handle() {
        switch nextField.fieldType {
        case .primary:
            checkForPrimary()
        case .secondary:
            checkForSecondary()
        case .ternary:
            checkForTernary()
            return
        }
        super.handle()
    }
    
    private func checkForPrimary() {
        for field in nextField.neighbors {
            if field.row == nextField.row && field.fieldState.rawValue == playerState.rawValue {
                mice.row = nextField.row
            }
            if field.col == nextField.col && field.fieldState.rawValue == playerState.rawValue {
                mice.col = nextField.col
            }
        }
    }
    
    private func checkForSecondary() {
        if checkForRowNeighbors() == 2 {
            if checkForRowNeighborsForMice() == 2 {
                mice.row = nextField.row
                mice.hasRowMice = true
            }
            for field in nextField.neighbors {
                if field.col == nextField.col && field.fieldState.rawValue == playerState.rawValue {
                    mice.col = nextField.col
                }
            }
        }else{
            if checkForColNeighborsForMice() == 2 {
                mice.col = nextField.col
                mice.hasColMice = true
            }
            for field in nextField.neighbors {
                if field.row == nextField.row && field.fieldState.rawValue == playerState.rawValue {
                    mice.row = nextField.row
                }
            }
        }
    }
    
    private func checkForTernary() {
        var numberRow = 0
        var numberCol = 0
        for field in nextField.neighbors {
            if field.row == nextField.row && field.fieldState.rawValue == playerState.rawValue {
                numberRow += 1
            }
            if field.col == nextField.col && field.fieldState.rawValue == playerState.rawValue {
                numberCol += 1
            }
        }
        if numberRow == 2 {
            mice.row = nextField.row
            mice.hasRowMice = true
        }
        if numberCol == 2 {
            mice.col = nextField.col
            mice.hasColMice = true
        }
    }
    
    private func checkForRowNeighbors() -> Int {
        var numberOfRowNeighbors = 0
        for field in nextField.neighbors {
            if field.row == nextField.row {
                numberOfRowNeighbors += 1
            }
        }
        return numberOfRowNeighbors
    }
    
    private func checkForRowNeighborsForMice() -> Int {
        var number = 0
        for field in nextField.neighbors {
            if field.row == nextField.row && field.fieldState.rawValue == playerState.rawValue {
                number += 1
            }
        }
        return number
    }
    
    private func checkForColNeighborsForMice() -> Int {
        var number = 0
        for field in nextField.neighbors {
            if field.col == nextField.col && field.fieldState.rawValue == playerState.rawValue {
                number += 1
            }
        }
        return number
    }
}
