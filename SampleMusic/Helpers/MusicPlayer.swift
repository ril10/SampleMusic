//
//  MusicPlayer.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 22.11.21.
//

import Foundation
import AVFAudio
import Dip


class MusicPlayer {
    
    var player = AVAudioPlayer()
    var isPlay = false
    
    func configure(sampleData: String) {
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            let urlString = sampleData
            let url = URL(string: urlString)
            let data = try! Data(contentsOf: url!)
            player = try AVAudioPlayer(data: data)
            if isPlay == true {
                player.play()
            } else {
                player.stop()
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func playMusic() {
        self.isPlay = true
    }
    
    func stopMusic() {
        self.isPlay = false
    }
    
}
extension MusicPlayer : MusicPlayerProtocol {}
