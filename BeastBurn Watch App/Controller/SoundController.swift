//
//  SoundController.swift
//  HeartRate Watch App
//
//  Created by Yehezkiel Salvator Christanto on 25/05/23.
//

import AVFoundation

class SoundController: ObservableObject, SoundPlaying {
    var audioPlayer: AVAudioPlayer?
    
    
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
}
