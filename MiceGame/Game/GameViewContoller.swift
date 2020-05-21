//
//  GameViewContoller.swift
//  Mice
//
//  Created by Vukašin Prvulović on 12/4/19.
//  Copyright © 2019 Vukašin Prvulović. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import MiceDomain

class GameViewController: BaseViewController, UIGestureRecognizerDelegate {
    
    var continueGame: Bool = false
    var gameViewModel: GameViewModel?
    
    var menuView: GameMenuView? = nil
    var playgroundView: PlaygroundView? = nil
    var pauseView: PauseView? = nil
    var winnerView: WinnerView? = nil
    
    @IBOutlet weak var movableToken: UIImageView!
    @IBOutlet weak var playerOneBusket: UIImageView!
    @IBOutlet weak var playerTwoBasket: UIImageView!
    @IBOutlet weak var playground: UIImageView!
    @IBOutlet weak var playerTwoLabel: UILabel!
    @IBOutlet weak var playerOneLabel: UILabel!
    @IBOutlet weak var playerTwoTokens: UILabel!
    @IBOutlet weak var playerOneTokens: UILabel!
    @IBOutlet weak var undo: UIImageView!
    @IBOutlet weak var pause: UIImageView!
    @IBOutlet weak var menu: UIImageView!
    
    @IBOutlet var menuTapGesture: UITapGestureRecognizer!
    @IBOutlet var pauseTapGesture: UITapGestureRecognizer!
    @IBOutlet var undoTapGesture: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        gameViewModel = container?.container.resolve(GameViewModel.self)
        gameViewModel!.continueGame = self.continueGame
        gameViewModel!.viewDidLoad()
        createPlaygroundView()
        setTapCallbacks()
        subscribeForGame()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator:UIViewControllerTransitionCoordinator) {
        if let menuView = self.menuView {
            menuView.removeFromSuperview()
        }
        if let playground = self.playgroundView {
            playground.removeFromSuperview()
        }
        if let pause = self.pauseView {
            pause.removeFromSuperview()
        }
        self.view.layoutSubviews()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if(gameViewModel!.game?.gameState.winnerState != .noWinner){
            return false
        }
        if gameViewModel!.game?.gameState.miceMadeState == .miceIsMade {
            if touch.view != playgroundView {return false}
            gameViewModel!.previousField = playgroundView!.isField(location: touch.location(in: self.view))
            gameViewModel?.play(nextField: playgroundView!.isField(location: touch.location(in: self.view)) ?? "")
            playgroundView?.removePlayerFromField(gameViewModel!.previousField!)
            return false
        }
        switch gameViewModel!.game?.gameState.setState {
        case .stillSet:
            if touch.view!.tag == 1 && gameViewModel!.game!.gameState.nextPlayerState == .playerOne {
                gameViewModel!.takeTokenPlay()
                return true
            }
            if touch.view!.tag == 2 && gameViewModel!.game!.gameState.nextPlayerState == .playerTwo {
                gameViewModel!.takeTokenPlay()
                return true
            }
            return false
        case .setOver:
            guard touch.view == playgroundView else {
                return false
            }
            let fieldTag = playgroundView!.isField(location: touch.location(in: self.view))
            if let tag = fieldTag {
                let field = gameViewModel!.game?.fields[tag]
                if gameViewModel!.game!.gameState.nextPlayerState == .playerOne && field?.fieldState == .playerOne {
                    gameViewModel!.takeTokenPlay()
                    gameViewModel!.previousField = tag
                    return true
                }
                if gameViewModel!.game!.gameState.nextPlayerState == .playerTwo && field?.fieldState == .playerTwo {
                    gameViewModel!.takeTokenPlay()
                    gameViewModel!.previousField = tag
                    return true
                }
            }
            return false
        default:
            print("default")
        }
        return true
    }
    
    @IBAction func onPlayerOneBasketTouch(_ sender: UIPanGestureRecognizer) {
        
        let location = sender.location(in: self.view)
        let translation = sender.translation(in: self.view)
        
        switch sender.state {
        case .began:
            movableToken.isHidden = false
            movableToken.frame.origin.x = location.x - movableToken.frame.width
            movableToken.frame.origin.y = location.y - movableToken.frame.height
            /*if gameViewModel!.game?.gameState.setState == .setOver {
                playgroundView!.removePlayerFromField(gameViewModel!.previousField!)
            }*/
        case .changed:
            movableToken.frame.origin.x += translation.x
            movableToken.frame.origin.y += translation.y
        case .ended:
            movableToken.isHidden = true
            if let field = playgroundView?.isField(location: location) {
                gameViewModel!.putTokenPlay()
                gameViewModel!.play(nextField: field)
            }
        default:
            print("default")
        }
    
        sender.setTranslation(.zero, in: view)
    }
    
    private func subscribeForGame() {
        gameViewModel?.gameBehavioralRelay.subscribe(onNext: { game in
            if let game = game {
                if game.gameState.miceMadeState == .miceIsMade {
                    self.gameViewModel!.miceMadePlay()
                }
                if game.gameState.winnerState != .noWinner {
                    self.showWinnerView()
                    return
                }
                if game.numberOfPlayers > 0 {
                    self.playerOneTokens.text = "More: \(game.numberOfPlayers/2)"
                }
                if game.numberOfPlayers == 0 {
                    self.playerOneTokens.text = "More: 0"
                    self.playerTwoTokens.text = "More: 0"
                    self.playerOneBusket.image = #imageLiteral(resourceName: "empty_basket")
                    self.playerTwoBasket.image = #imageLiteral(resourceName: "empty_basket")
                }else{
                    self.playerOneBusket.image = #imageLiteral(resourceName: "basket_player_one")
                    self.playerTwoBasket.image = #imageLiteral(resourceName: "basket_player_two")
                }
                switch game.gameState.nextPlayerState {
                case .playerOne:
                    self.movableToken.image = #imageLiteral(resourceName: "ic_player_one_move")
                    self.playerOneLabel.text = "\(self.gameViewModel?.names?.0 ?? "") - your turn"
                    self.playerTwoLabel.text = self.gameViewModel?.names?.1 ?? ""
                    if game.numberOfPlayers > 0 {
                        self.playerTwoTokens.text = "More: \(game.numberOfPlayers/2)"
                    }
                case .playerTwo:
                    self.movableToken.image = #imageLiteral(resourceName: "ic_player_two_move")
                    self.playerOneLabel.text = self.gameViewModel?.names?.0 ?? ""
                    self.playerTwoLabel.text = "\(self.gameViewModel?.names?.1 ?? "") - your turn"
                    if game.numberOfPlayers > 0 {
                        self.playerOneTokens.text = "More: \(game.numberOfPlayers/2)"
                    }
                }
                self.playgroundView?.drawGameState(fields: game.fields)
            }
        }, onError: { error in
            
        }).disposed(by: disposeBag)
    }
    
    private func setTapCallbacks() {
        
        menuTapGesture.rx.event.asSignal()
        .emit(onNext: { gesture in
            self.menu.animateButton {
            if self.menuView == nil {
                registerGameMenuViewModel(container: self.container!.container)
                self.menuView = GameMenuView(self.container!.container.resolve(GameMenuViewModel.self)!, frame: UIScreen.main.bounds)
                self.initGameMenuView(self.menuView!)
            }
            guard let menuView = self.menuView else { return }
            menuView.frame = UIScreen.main.bounds
            self.view.addSubview(menuView)
            self.view.layoutSubviews()
            }
        }).disposed(by: disposeBag)
        
        pauseTapGesture.rx.event.asSignal()
        .emit(onNext: { gesture in
            self.pause.animateButton {
            if self.pauseView == nil {
                self.pauseView = PauseView(frame: UIScreen.main.bounds)
                self.pauseView?.onLongPauseClicked = { [weak self] in
                    self?.pauseView?.removeFromSuperview()
                }
                self.view.addSubview(self.pauseView!)
                self.view.bringSubviewToFront(self.pauseView!)
                self.view.layoutSubviews()
            }else {
                self.view.addSubview(self.pauseView!)
                self.view.bringSubviewToFront(self.pauseView!)
                self.view.layoutSubviews()
            }
        }
        }).disposed(by: disposeBag)
        
        undoTapGesture.rx.event.asSignal()
        .emit(onNext: { gesture in
            self.undo.animateButton {
                self.gameViewModel!.undo()
            }
        }).disposed(by: disposeBag)
    }
    
    private func initGameMenuView(_ menuView: GameMenuView){
        menuView.getExitClickEvent().emit(onNext: { [weak self] tapGesture in
                self?.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        menuView.getMenuExitClickEvent().emit(onNext: { longGesture in
            menuView.removeFromSuperview()
            }).disposed(by: disposeBag)
    }
    
    private func calculateFrame(level: Int, for view: UIView) -> CGRect {
    
        var x: CGFloat = view.frame.origin.x
        var y: CGFloat = view.frame.origin.y
        
        var superView: UIView? = view
        
        for _ in 0..<level {
            superView = superView?.superview
            x += superView?.frame.origin.x ?? CGFloat.zero
            y += superView?.frame.origin.y ?? CGFloat.zero
        }
        
        return CGRect(x: x, y: y, width: view.frame.width, height: view.frame.height)
    }
    
    private func createPlaygroundView() {
        gameViewModel?.getFieldTags()
        .subscribe(onSuccess: { success in
            self.playgroundView = PlaygroundView(frame: UIScreen.main.bounds,fields: success)
            guard let playgroundView = self.playgroundView else {
                return
            }
            self.view.addSubview(playgroundView)
            playgroundView.translatesAutoresizingMaskIntoConstraints = false
            if self.view.frame.width < self.view.frame.height  {
                    let constraints = [
                        playgroundView.widthAnchor.constraint(equalTo: self.playground.widthAnchor, multiplier: 0.9),
                        playgroundView.heightAnchor.constraint(equalTo: self.playground.widthAnchor, multiplier: 0.9),
                        NSLayoutConstraint(item: playgroundView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0),
                        NSLayoutConstraint(item: playgroundView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 0.97, constant: 0)
                    ]
                    NSLayoutConstraint.activate(constraints)
            }else{
                    let constraints = [
                        playgroundView.widthAnchor.constraint(equalTo: self.playground.heightAnchor, multiplier: 0.9),
                        playgroundView.heightAnchor.constraint(equalTo: self.playground.heightAnchor, multiplier: 0.9),
                        NSLayoutConstraint(item: playgroundView, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 0.6, constant: 0),
                        NSLayoutConstraint(item: playgroundView, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
                    ]
                    NSLayoutConstraint.activate(constraints)
                }
            self.view.bringSubviewToFront(self.movableToken)
        }, onError: { error in
            
            }).disposed(by: disposeBag)
    }
    
    private func showWinnerView() {
        if let winner = winnerView {
            self.view.addSubview(winner)
            self.view.layoutIfNeeded()
        }else{
            winnerView = WinnerView(frame: UIScreen.main.bounds)
            winnerView?.longPress.rx.event.asSignal()
            .emit(onNext: { gesture in
                self.winnerView?.removeFromSuperview()
                }).disposed(by: disposeBag)
            self.view.addSubview(winnerView!)
            self.view.layoutIfNeeded()
        }
    }
}
