//
//  ContentView.swift
//  KulingensApp
//
//  Created by Toni Löf on 2022-01-17.
//

import SwiftUI
import CoreData
import AVKit

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Sign.name, ascending: true)],
        animation: .default)
    private var signs: FetchedResults<Sign>
    
    @State private var isExpanded = false
    @State private var isLocked = true
    @State var createViewIsActive = false
    @State var activeSign: Sign? = nil
    @State var isMenuActive = false
    @State var infoIsShowing = false
    @State var audioRecorder = AudioRecorder()
    @State var audioString = ""
    @State var audioUrl: String = ""
    @State var videoUrl = ""
    @ObservedObject var audioPlayer = AudioPlayer()
    
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                HStack{
                    NavigationLink(destination: GameView()){
                        Text("Öva")
                            .foregroundColor(Color.white)
                            .font(.title2)
                            .padding(EdgeInsets(top:0, leading: 20, bottom: 0, trailing: 0))
                    }
                    
                    Spacer()
                    
                    if isLocked == false {
                        
                        Button(action: {
                            createViewIsActive = true
                            
                        }, label: {
                            Text("Nytt tecken")
                                .foregroundColor(Color.white)
                                .font(.title2)
                            
                            
                        })
                            .padding()
                        
                        Button(action: {
                            deleteItems()
                            deleteAudioFile()
                            
                            if signs.count != 0 {
                                activeSign = signs[0]
                                fetchSignAudio()
                                fetchVideoUrl()
                                
                            }
                            
                        }, label: {
                            Text("Radera")
                                .font(.title2)
                                .foregroundColor(Color.white)
                                .padding(10)
                                .background(Color(red: 184/256, green: 76/256, blue: 109/256 ))
                                .cornerRadius(15)

                        })
                        
                    }
                    
                    Spacer()
                    NavigationLink(destination: mainInfoView()){
                        Image(systemName: "questionmark.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    
                    Button(action: {
                        isLocked.toggle()
                    }, label: {
                        Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
                        
                            .foregroundColor(Color.white)
                    })
                        .onAppear {
                            
                            if signs.count != 0 {
                                
                                activeSign = signs[0]
                                
                                fetchSignAudio()
                            }
                        }
                        .padding()
                    
                    Button(action: {
                        isMenuActive = true
                    }, label: {
                        Text("Byt tecken")
                            .foregroundColor(Color.white)
                            .font(.title2)
                    })
                        .padding(EdgeInsets(top: 0, leading: 25, bottom: 0, trailing: 20))
                    
                }
                .background(Color(red: 2/256, green: 116/256, blue: 138/256 ))
                .padding()
                
                
                Spacer()
                
                if let activeSign = activeSign {
                    HStack{
                        
                        Text(activeSign.name!)
                            .padding()
                            .background(Color(red: 92/256, green: 177/256, blue: 199/256 ))
                            .cornerRadius(10)
                        
                        
                        Button(action: {
                            playAudio()
                            
                        }, label: {
                            Image(systemName: "speaker.wave.3.fill")
                                .padding()
                                .foregroundColor(Color.black)
                                .background(Color(red: 92/256, green: 177/256, blue: 199/256 ))
                                .cornerRadius(10)
                                .padding(.trailing, 530)
                        })
                            .onAppear(perform: {
                                fetchSignAudio()
                            })
                        
                    }
                    HStack{
                        VideoView(videoID: videoUrl)
                            .frame(minWidth: 200, maxWidth: 700, minHeight: 100, maxHeight: 500)
                            .padding(EdgeInsets(top:0, leading: 0, bottom: 10, trailing: 0))
                            .onAppear(perform: {
                                fetchVideoUrl()
                            })
                    }
                    
                    Spacer()
                }else{
                    
                    Text ("Det finns inga tecken att visa.")
                    Text("Skapa ett nytt genom att trycka på plus tecknet uppe i menyn.")
                    Spacer()
                    
                }
            }
            .background( Color(red: 210/256, green: 231/256, blue: 238/256 ))
            .sheet(isPresented: $createViewIsActive, onDismiss: { fetchSignAudio(); fetchVideoUrl()
            }) { CreateSignView(audioRecorder: audioRecorder, activeSign: $activeSign) }
            .sheet(isPresented: $isMenuActive, onDismiss: { fetchSignAudio(); fetchVideoUrl() }) { SignListView(activeSign: $activeSign) }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
        .accentColor(.white)
  
    }
    
    private func fetchVideoUrl() {
        videoUrl = ""
        if let activeSign = activeSign {
            if let video = activeSign.videoUrl {
                if video.count > 3 {
                    videoUrl = video
                }else{
                    videoUrl = ""
                }
            }else{
                videoUrl = ""
            }
        }
    }
    
    private func deleteItems() {
        
        guard let activeSign = activeSign else {
            return
        }
        
        viewContext.delete(activeSign)
        print(signs.count)
        self.activeSign = nil
        
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    func fetchSignAudio(){
        
        if let activeSign = activeSign {
            if let name = activeSign.audioName {
                if name.count > 1 {
                    audioString = name
                }else{
                    audioString = ""
                    audioUrl = ""
                }
            }
        }
        let testList = self.audioRecorder.recordings
        
        for recording in testList {
            let dodo = recording.fileURL.absoluteString.suffix(24)
            
            if dodo == audioString {
                audioUrl = String(recording.fileURL.absoluteString)
                
            }
        }
    }
    
    func playAudio() {
        if audioUrl.count > 3 {
            if let playUrl = URL(string: audioUrl){
                self.audioPlayer.startPlayback(audio: playUrl)
            }
        }else{
            self.audioPlayer.playErrorAudio()
        }
    }
    
    func deleteAudioFile() {
        
        if let deleteUrl = URL(string: audioUrl){
            
            self.audioRecorder.deleteSingleRecording(urlToDelete: deleteUrl)
        }else{
            
            print("DELETE AUDIO FILE URL BROKEN!!")
        }
        
    }
    
    
    
}


