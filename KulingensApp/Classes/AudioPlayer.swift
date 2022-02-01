//
//  AudioPlayer.swift
//  KulingensApp
//
//  Created by Toni Löf on 2022-02-01.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioPlayer:  NSObject, ObservableObject, AVAudioPlayerDelegate {
    
    let objectWillChange = PassthroughSubject<AudioPlayer, Never>()
    var audioPlayer: AVAudioPlayer!
    var isPlaying = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    
    func startPlayback (audio: URL) {
        
        let playbackSession = AVAudioSession.sharedInstance()
        
        // Det här kan du nog kommentera bort
        //        do {
        //                    try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        //                } catch {
        //                    print("Playing over the device's speakers failed")
        //                }
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            print("AudioPlayer startPlayback audio URL:  \(audio)")
            audioPlayer.delegate = self
            audioPlayer.play()
            isPlaying = true
        } catch {
            print("Playback failed.")
        }
        
    }
    
    
    func stopPlayback() {
        audioPlayer.stop()
        isPlaying = false
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
            if flag {
                isPlaying = false
            }
        }
    
}
