//
//  File.swift
//  
//
//  Created by Vukašin Prvulović on 12/8/19.
//

import Foundation

public struct GameState {
    public let nextPlayerState: PlayerState
    public let miceMadeState: MiceMadeState
    public let setState: SetState
    public let winnerState: WinnerState
    
    func copy(newNextPlayerState: PlayerState? = nil, newMiceMadeState: MiceMadeState? = nil,
              newSetState: SetState? = nil, newWinnerState: WinnerState? = nil) -> GameState {
        return GameState(nextPlayerState: newNextPlayerState ?? self.nextPlayerState, miceMadeState: newMiceMadeState ?? self.miceMadeState, setState: newSetState ?? self.setState, winnerState: newWinnerState ?? self.winnerState)
    }
}
