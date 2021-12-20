//
//  MusicPlayer.swift
//  SampleMusic
//
//  Created by Siarhei Luk on 22.11.21.
//

import Foundation
import AVFAudio
import Dip


class MusicPlayer: NSObject,AVAudioPlayerDelegate {
    
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
            player?.delegate = self
            player?.prepareToPlay()
            playMusic(isPlay: isPlay)

        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        if flag {
            player.pause()
        }
    }
    
    func playMusicAt(_ value: Int) {
        player?.pause()
        player?.currentTime = TimeInterval(value)
        player?.prepareToPlay()
        player?.play()
    }
    
    func playMusic(isPlay: Bool) {
        if isPlay {
            player?.play()
        } else {
            player?.pause()
        }
    }
    
}
extension MusicPlayer : MusicPlayerProtocol {}
