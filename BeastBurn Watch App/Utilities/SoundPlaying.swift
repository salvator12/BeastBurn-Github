//
//  SoundControl.swift
//  HeartRate Watch App
//
//  Created by Yehezkiel Salvator Christanto on 25/05/23.
//

import AVFoundation

protocol SoundPlaying: AnyObject {
    var audioPlayer: AVAudioPlayer? { get set }
}

extension SoundPlaying {
    func playSound(name: String) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            fatalError("unable to find sound file \(name).mp3")
        }
        try? audioPlayer = AVAudioPlayer(contentsOf: url)
        audioPlayer?.play()
    }
}
