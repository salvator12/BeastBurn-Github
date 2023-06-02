//
//  SoundControl.swift
//  HeartRate Watch App
//
//  Created by Yehezkiel Salvator Christanto on 25/05/23.
//

import AVFoundation
import WatchKit

protocol SoundPlaying: AnyObject {
    var audioPlayer: AVAudioPlayer? { get set }
    var session: AVAudioSession {get set}
}

extension SoundPlaying {
    
    
    func playSound(name: String) {
        
        
        do {
            try session.setCategory(AVAudioSession.Category.playback, mode: .default, policy: .default, options: [])
        } catch let error {
            fatalError("*** Unable to set up the audio session: \(error.localizedDescription) ***")
        }
        
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            fatalError("unable to find sound file \(name).mp3")
        }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        } catch let error {
            print("*** Unable to set up the audio player: \(error.localizedDescription) ***")
            // Handle the error here.
            return
        }
        
        session.activate(options: []) { (success, error) in
            guard error == nil else {
                print("*** An error occurred: \(error!.localizedDescription) ***")
                // Handle the error here.
                return
            }
            self.audioPlayer?.play()
        }
        
        try? audioPlayer = AVAudioPlayer(contentsOf: url)
        
    }
}
