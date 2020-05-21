//
//  UIView+Animations.swift
//  MiceGame
//
//  Created by Vukašin Prvulović on 12/9/19.
//  Copyright © 2019 Vukašin Prvulović. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func animateButtonDown() {
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.center.y = self.center.y + 5
        })
    }
    
    func animateButtonUp(endAction: @escaping () -> Void) {
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.center.y = self.center.y - 5
        },
            completion: { _ in
                endAction()
        })
    }
    
    func animateButton(endAction: @escaping () -> Void) {
        UIView.animate(
            withDuration: 0.2,
            animations: {
                self.center.y = self.center.y + 5
        },
            completion: { _ in
                UIView.animate(
                    withDuration: 0.2,
                    animations: {
                        self.center.y = self.center.y - 5
                },
                    completion: { _ in
                        endAction()
                })
        })
    }
}
