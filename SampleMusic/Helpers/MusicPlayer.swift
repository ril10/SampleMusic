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
    
    var player : AVAudioPlayer?
    var isPlay = false
    var time : ((Int) -> Void)?
    
    func configure(sampleData: String) {
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            let urlString = sampleData
            let url = URL(string: urlString)
            let data = try! Data(contentsOf: url!)
            player = try AVAudioPlayer(data: data)
            if isPlay == true {
                player?.play()
            } else {
                player?.stop()
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        sampleTime(player)
    }
    
    func sampleTime(_ player: AVAudioPlayer?) {
        let time = Int(player!.duration)
        self.time?(time)
    }
    
    func playMusic() {
        self.isPlay = true
    }
    
    func stopMusic() {
        self.isPlay = false
    }
    
}
extension MusicPlayer : MusicPlayerProtocol {}
