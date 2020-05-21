//
//  PauseView.swift
//  Mice
//
//  Created by Vukašin Prvulović on 12/7/19.
//  Copyright © 2019 Vukašin Prvulović. All rights reserved.
//

import Foundation
import UIKit

class PauseView: ViewWithNib {
    
    var onLongPauseClicked: (() -> Void)? = nil
    
    @IBAction func longClick(_ sender: Any) {
        onLongPauseClicked?()
    }
}
