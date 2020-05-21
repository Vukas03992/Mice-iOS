//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

class DeleteMiceBaseHandler {
    
    var mice: Mice
    var previousField: Field
    var nextField: Field
    var next: DeleteMiceBaseHandler? = nil
    
    init(_ mice: Mice, _ previousField: Field, _ nextField: Field) {
        self.mice = mice
        self.previousField = previousField
        self.nextField = nextField
    }
    
    func addHandler(_ nextHandler: DeleteMiceBaseHandler){
        if let next = next {
            next.addHandler(nextHandler)
        }else{
            next = nextHandler
        }
    }
    
    func handle() {
        if let next = next {
            next.handle()
        }
    }
}
