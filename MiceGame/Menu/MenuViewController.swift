//
//  ViewController.swift
//  Mice
//
//  Created by Vukašin Prvulović on 11/20/19.
//  Copyright © 2019 Vukašin Prvulović. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var menuViewModel: MenuViewModel?
    
    override func viewDidLoad() {
        menuViewModel = container?.container.resolve(MenuViewModel.self)
        menuViewModel?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        menuViewModel!.viewWillAppear()
    }
    
    @IBAction func playersTapped(_ sender: UITapGestureRecognizer) {
        sender.view?.animateButtonUp { [weak self] in
            self?.performSegue(withIdentifier: "showPlayers", sender: nil)
        }
    }
    
    @IBAction func rulesTapped(_ sender: UITapGestureRecognizer) {
        sender.view?.animateButtonUp { [weak self] in
            self?.performSegue(withIdentifier: "showRules", sender: nil)
        }
    }
    
    @IBAction func exitTapped(_ sender: UITapGestureRecognizer) {
        sender.view?.animateButtonUp {
            exit(1)
        }
    }
    
    @IBAction func continueTapped(_ sender: UITapGestureRecognizer) {
        sender.view?.animateButtonUp { [weak self] in
            self?.performSegue(withIdentifier: "showNewGame", sender: 101)
        }
    }
    
    @IBAction func newGameTapped(_ sender: UITapGestureRecognizer) {
        sender.view?.animateButtonUp { [weak self] in
            self?.performSegue(withIdentifier: "showNewGame", sender: nil)
        }
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        gestureRecognizer.view?.animateButtonDown()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let gameContoller = segue.destination as? GameViewController, let senderCode = sender as? Int {
            if senderCode == 101 {
                gameContoller.continueGame = menuViewModel!.canContinue
            }
        }
    }
}

