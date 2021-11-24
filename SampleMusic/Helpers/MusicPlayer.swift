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
    
    func audioPlayerBeginInterruption(_ player: AVAudioPlayer) {
        print("playerBegin:\(player.currentTime)")
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        print("player:\(player.currentTime)")
    }
    
    func playMusicAt(_ at: Float) {
        let time = at * 10
        print(TimeInterval(Int(time)))
        player?.play(atTime: TimeInterval(Int(time)))
    }
    
    func playMusic(isPlay: Bool) {
        if isPlay {
            player?.play()

            let seconds = Int(player!.currentTime) % 60
            let minutes = Int(player!.currentTime / 60) % 60
            print(String(format: "%0.2d:%0.2d", minutes,seconds))
        } else {
            player?.stop()
            
            let seconds = Int(player!.currentTime) % 60
            let minutes = Int(player!.currentTime / 60) % 60
            print(String(format: "%0.2d:%0.2d", minutes,seconds))
        }
    }
    
}
extension MusicPlayer : MusicPlayerProtocol {}
