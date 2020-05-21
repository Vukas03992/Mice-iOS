//
//  UIViewController+Container.swift
//  MiceGame
//
//  Created by Vukašin Prvulović on 12/9/19.
//  Copyright © 2019 Vukašin Prvulović. All rights reserved.
//

import Foundation
import UIKit
import Swinject

extension UIViewController {
    
    var container: MiceContainer?{
        get {
            (UIApplication.shared.delegate as! AppDelegate).container
        }
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
