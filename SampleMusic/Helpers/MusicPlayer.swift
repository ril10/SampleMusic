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
    
    func configure(sampleData: String) {
        self.isPlay.toggle()
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            let urlString = sampleData
            let url = URL(string: urlString)
            let data = try! Data(contentsOf: url!)
            player = try AVAudioPlayer(data: data)
            playMusic(isPlay: isPlay)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func playMusicAt(_ at: Float) {
        let time = at * 10
        print(TimeInterval(Int(time)))
        player?.play(atTime: TimeInterval(Int(time)))
    }
    
    func playMusic(isPlay: Bool) {
        if isPlay {
            player?.play()
        } else {
            player?.stop()
        }
    }
    
}
extension MusicPlayer : MusicPlayerProtocol {}
