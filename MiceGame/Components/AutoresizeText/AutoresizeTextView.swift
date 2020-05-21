//
//  AutoresizeTextField.swift
//  Mice
//
//  Created by Vukašin Prvulović on 12/2/19.
//  Copyright © 2019 Vukašin Prvulović. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class AutoresizeTextView: UITextView {
    
    @IBInspectable var minTextSize: CGFloat = 0
    @IBInspectable var maxTextSize: CGFloat = 0 {
        didSet {
            if(self.maxTextSize != 0){
                setFont()
            }
        }
    }
    
    private let iphone5SscreenWidth = CGFloat(320.0)
    private let iphone11MAXscreenWidth = CGFloat(414.0)
    private let maxScreenDiff = CGFloat(414.0) - CGFloat(320.0)
    
    private func calculate() -> CGFloat {
        let screenWidth = UIScreen.main.bounds.width
        switch screenWidth {
        case iphone5SscreenWidth:
            return minTextSize
        case iphone11MAXscreenWidth:
            return maxTextSize
        default:
            let screenScaleFactor = (screenWidth - iphone5SscreenWidth)/maxScreenDiff
            let scaledFontSize = minTextSize + screenScaleFactor*getTextSizeDiff()
            return min(scaledFontSize, maxTextSize)
        }
    }
    
    private func getTextSizeDiff() -> CGFloat {
        return maxTextSize - minTextSize
    }

    private func setFont(){
        self.font = UIFont(name: (self.font?.fontName)!, size: calculate())
    }
}
