//
//  PlayersViewController.swift
//  Mice
//
//  Created by Vukašin Prvulović on 11/28/19.
//  Copyright © 2019 Vukašin Prvulović. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class PlayersViewController: UIViewController, UITextFieldDelegate{
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var playerOne: UITextField!
    @IBOutlet weak var playerTwo: UITextField!
    
    var playersViewModel: PlayersViewModel?
    
    override func viewDidLoad() {
        playerOne.attributedPlaceholder = NSAttributedString(string: "player one", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.92, green: 0.83, blue: 0.78, alpha: 1)])
        playerTwo.attributedPlaceholder = NSAttributedString(string: "player two", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 0.92, green: 0.83, blue: 0.78, alpha: 1)])
        hideKeyboardWhenTappedAround()
        playerOne.delegate = self
        playerTwo.delegate = self
        playersViewModel = container?.container.resolve(PlayersViewModel.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        playersViewModel?.playersNamesRelay
            .subscribe { [weak self] event in
                guard let value = event.element else { return }
                if !value.0.isEmpty { self?.playerOne.text = value.0}
                if !value.1.isEmpty { self?.playerTwo.text = value.1}
        }.disposed(by: disposeBag)
        playersViewModel?.viewWillAppear()
    }
    
    @IBAction func dismiss() {
        dismiss(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            playerOne.resignFirstResponder()
            playerTwo.becomeFirstResponder()
        }else if textField.tag == 2{
            playerTwo.resignFirstResponder()
            playersViewModel?.saveNames(playerOne: playerOne.text, playerTwo: playerTwo.text)
        }
        return true
    }
}
