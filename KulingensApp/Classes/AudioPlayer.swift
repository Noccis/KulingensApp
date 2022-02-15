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
        
        do {
            print("AudioPlayer startPlayback audio URL:  ::\(audio)::")
            audioPlayer = try AVAudioPlayer(contentsOf: audio)
            audioPlayer.delegate = self
            audioPlayer.play()
            isPlaying = true
        } catch {
            playErrorAudio()
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
    
    func playErrorAudio() {
        guard let soundFileURL = Bundle.main.url(
            forResource: "invalid", withExtension: "mp3"
        ) else {
            print("ERRORAUDIO NOT FOUND!")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundFileURL)
            audioPlayer.delegate = self
            audioPlayer.play()
            isPlaying = true
        }catch {
            print("Playback failed.")
        }
        
    }
}
