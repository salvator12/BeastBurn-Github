//
//  SoundController.swift
//  HeartRate Watch App
//
//  Created by Yehezkiel Salvator Christanto on 25/05/23.
//

import AVFoundation
import WatchKit


class SoundController: ObservableObject, SoundPlaying {
    var audioPlayer: AVAudioPlayer?
    var session: AVAudioSession = AVAudioSession.sharedInstance()
    
    func countdown3() {
        playSound(name: "3")
    }
    
    func countdown2() {
        playSound(name: "2")
    }
    
    func countdown1() {
        playSound(name: "1")
    }
    func countdownGo() {
        playSound(name: "Go")
    }
    
    func heal() {
        playSound(name: "heal-up")
    }
    
    func hitMonster() {
        playSound(name: "hit")
    }
    
    func gameOver() {
        playSound(name: "gameOver")
    }
    
    func win() {
        playSound(name: "win")
    }
}
