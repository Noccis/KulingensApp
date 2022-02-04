//
//  AudioRecorder.swift
//  KulingensApp
//
//  Created by Toni Löf on 2022-02-01.
//

import Foundation
import SwiftUI
import Combine
import AVFoundation

class AudioRecorder: NSObject, ObservableObject {
    
    let objectWillChange = PassthroughSubject<AudioRecorder, Never>()
    var audioRecorder: AVAudioRecorder!
    var recordings = [Recording]()              // Create active recording to get url?
    var recording = false {
        didSet {
            objectWillChange.send(self)
        }
    }
    
    override init() {
           super.init()
           fetchRecordings()
       }
    
    
    func startRecording()-> String {
        let recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            print("Failed to set up recording session")
        }
        
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let audioFilename = documentPath.appendingPathComponent("\(Date().toString(dateFormat: "dd-MM-YY_'at'_HH:mm:ss")).m4a")
        print("AUDIORECORDER audioFilename::\(audioFilename)::")
        
        let audioName = String(audioFilename.absoluteString.suffix(24))
        print("AUDIORECORDER audioName::\(audioName)::")
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder.record()
            
            recording = true
        } catch {
            print("Could not start recording")
        }
        
        return audioName
    }
    
    func stopRecording() {
           audioRecorder.stop()
           recording = false
        fetchRecordings()
       }
    
    
    func fetchRecordings() {
            recordings.removeAll()
            
            let fileManager = FileManager.default
            let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
            for audio in directoryContents {
                
                let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
                print("\(recording.fileURL)")
                          recordings.append(recording)
            }
        // Behöver denna rad vara med?
   //     recordings.sort(by: { $0.createdAt.compare($1.createdAt) == .orderedAscending})
                
                objectWillChange.send(self)
        }
    
    func fetchSingleRecording() {
        
        recordings.removeAll()
        
        let fileManager = FileManager.default
        let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
        for audio in directoryContents {
            
            let recording = Recording(fileURL: audio, createdAt: getCreationDate(for: audio))
            print("\(recording.fileURL)")
                      recordings.append(recording)
        }
            
            objectWillChange.send(self)     // Behöver jag ha med denna?
        
        
    }
    func deleteSingleRecording(urlToDelete: URL){
       
        do {
           try FileManager.default.removeItem(at: urlToDelete)
            print("DELETED!!")
        } catch {
            print("File could not be deleted!")
        }
        
        fetchRecordings()
        
    }
    func deleteRecording(urlsToDelete: [URL]) {
            
            for url in urlsToDelete {
                print(url)
                do {
                   try FileManager.default.removeItem(at: url)
                } catch {
                    print("File could not be deleted!")
                }
            }
            
            fetchRecordings()
            
        }
    
}
