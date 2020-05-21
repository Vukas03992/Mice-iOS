//
//  MusicAndSoundManager.swift
//  MiceGame
//
//  Created by Vukašin Prvulović on 12/9/19.
//  Copyright © 2019 Vukašin Prvulović. All rights reserved.
//

import Foundation
import AVFoundation

class MusicAndSoundManager {
    
    private var music: AVAudioPlayer?
    private var takeToken: AVAudioPlayer?
    private var putToken: AVAudioPlayer?
    private var miceMade: AVAudioPlayer?
    
    func playerMusic(file: String){
        
        if let music = self.music {
            music.play()
        }else{
            let path = Bundle.main.path(forResource: file, ofType:nil)!
            let url = URL(fileURLWithPath: path)

            do {
                music = try AVAudioPlayer(contentsOf: url)
                music?.numberOfLoops = -1
                music?.play()
            } catch {
                print("ne moze da nadje file")
            }
        }
    }
    
    func stopMusic(){
        music?.stop()
    }
    
    func prepareSoundEffects(takeToken: String, putToken: String, miceMade: String) {
        if self.takeToken == nil {
            let path = Bundle.main.path(forResource: takeToken, ofType:nil)!
            let url = URL(fileURLWithPath: path)
            
            do {
                self.takeToken = try AVAudioPlayer(contentsOf: url)
            } catch {
                print("ne moze da nadje file")
            }
        }
        if self.putToken == nil {
            let path = Bundle.main.path(forResource: putToken, ofType:nil)!
            let url = URL(fileURLWithPath: path)
            
            do {
                self.putToken = try AVAudioPlayer(contentsOf: url)
            } catch {
                print("ne moze da nadje file")
            }
        }
        if self.miceMade == nil {
            let path = Bundle.main.path(forResource: miceMade, ofType:nil)!
            let url = URL(fileURLWithPath: path)
            
            do {
                self.miceMade = try AVAudioPlayer(contentsOf: url)
            } catch {
                print("ne moze da nadje file")
            }
        }
    }
    
    func putTokenPlay() {
        putToken?.play()
    }
    
    func takeTokenPlay() {
        takeToken?.play()
    }
    
    func miceMadePlay() {
        miceMade?.play()
    }
}
