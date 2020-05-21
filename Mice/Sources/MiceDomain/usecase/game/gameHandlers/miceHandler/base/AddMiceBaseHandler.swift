//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class AddMiceBaseHandler {

    var mice: Mice
    var nextField: Field
    var playerState: PlayerState
    var next: AddMiceBaseHandler? = nil
    
    init(_ mice: Mice, _ nextField: Field, _ playerState: PlayerState) {
        self.mice = mice
        self.nextField = nextField
        self.playerState = playerState
    }
    
    func addHandler(_ nextHandler: AddMiceBaseHandler){
        if let next = self.next {
            next.addHandler(nextHandler)
        }else{
            next = nextHandler
        }
    }
    
    func handle(){
        if let next = self.next {
            next.handle()
        }
    }
}
