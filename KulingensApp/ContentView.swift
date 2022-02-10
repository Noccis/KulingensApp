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
    private var pinCode: Int? = nil
    //  @State var audioPlayer: AVAudioPlayer!
    @ObservedObject var audioPlayer = AudioPlayer()
    
    
    
    let urlName = "file:///Users/tonilof/Library/Developer/CoreSimulator/Devices/4846ABA4-92A8-4AB0-A360-9E0B93F695E0/data/Containers/Data/Application/F5878356-E741-49D3-AA1A-7ADB26C2B4E1/Documents/01-02-22_at_12:40:38.m4a"
    
    
    
    
    var body: some View {
        
        NavigationView {
            
            
            VStack {
                
                HStack{
                    NavigationLink(destination: GameView()){
                        Text("Öva")
                            .foregroundColor(Color.white)
                            .font(.title3)
                            .padding(EdgeInsets(top:0, leading: 20, bottom: 0, trailing: 0))
                    }
                    //                    Text("Searchfunction")
                    //                        .foregroundColor(Color.white)
                    //                        .padding()
                    Spacer()
                    
                    if isLocked == false {
                        
                        Button(action: {
                            createViewIsActive = true
                            
                        }, label: {
                            Text("Nytt tecken")
                                .foregroundColor(Color.white)
                            
                            
                        })
                            .padding()
                        
                        Button(action: {
                            deleteItems()
                            deleteAudioFile()
                            
                            if signs.count != 0 {
                                activeSign = signs[0]
                                fetchSignAudio()
                                
                            }
                            
                        }, label: {
                            Text("Delete")
                        })
                            .foregroundColor(Color.white)
                    }
                    
                    Spacer()
                    NavigationLink(destination: mainInfoView()){
                        Image(systemName: "questionmark.circle.fill")
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
                    
                    Button(action: {
                        isMenuActive = true
                    }, label: {
                        Text("Byt tecken")
                            .foregroundColor(Color.white)
                    })
                        .padding()
                    
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
                        //    .padding(EdgeInsets(top:0, leading: 200, bottom: 0, trailing: 0))
                        
                        
                        //   Text("Audio file")
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
                        
                        //                                            Button(action: {
                        //                                                self.audioPlayer.playErrorAudio()
                        //
                        //                                            }, label: {
                        //                                                Text("ERROR")
                        //                                            })
                        
                        
                    }
                    
                    
                    
                    HStack{
                        VideoView(videoID: activeSign.videoUrl!)
                            .frame(minWidth: 200, maxWidth: 700, minHeight: 100, maxHeight: 500)
                            .padding(EdgeInsets(top:0, leading: 0, bottom: 10, trailing: 0))
                        
                    }
                    Spacer()
                }else{
                    
                    Text ("Det finns inga tecken att visa.")
                    Text("Skapa ett nytt genom att trycka på plus tecknet uppe i menyn.")
                    Spacer()
                    
                }
                
            }
            .background( Color(red: 210/256, green: 231/256, blue: 238/256 ))
            .sheet(isPresented: $createViewIsActive, onDismiss: { fetchSignAudio()
            }) { CreateSignView(audioRecorder: audioRecorder, activeSign: $activeSign) }
            .sheet(isPresented: $isMenuActive, onDismiss: { fetchSignAudio() }) { SignListView(activeSign: $activeSign) }
            .navigationBarHidden(true)
        }
        .navigationViewStyle(.stack)
        
        
        
    }
    
    
    private func addSign() {
        withAnimation {
            let newSign = Sign(context: viewContext)
            newSign.name = "Klogli"
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
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
                //  print("1 FETCHSIGN NAME:\(name):: COUNT:::\(name.count)")
                if name.count > 1 {
                    audioString = name
                    //            print("2 AUDIOSTRING:::: \(audioString)")
                }else{
                    //         print("AUDIOSTRING SHOULD BE EMPTY")
                    audioString = ""
                    audioUrl = ""
                }
            }
        }
        // Behöver jag kalla på fetch recordings första gången appen körs?
        let testList = self.audioRecorder.recordings
        
        for recording in testList {
            let dodo = recording.fileURL.absoluteString.suffix(24)
            //  print("TESTLIST ::\(dodo)::")
            
            if dodo == audioString {
                //     print("PLaying!!!!!!!!!")
                //     print("FETCHSIGNRECORDING DODO IS SAME AS IN LIST! set: ::\(audioUrl)::")
                audioUrl = String(recording.fileURL.absoluteString)
                
                
                //  self.audioPlayer.startPlayback(audio: recording.fileURL)
            }
        }
    }
    
    func playAudio() {
        if audioUrl.count > 3 {
            //   print("AudioUrl bigger then 3, playing")
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
            
            // print("DELETE AUDIO FILE URL BROKEN!!")
        }
        
        //    print("AUDIO URL: ::\(audioUrl)::")
        
    }
    
    //    func playErrorAudio() {
    //        guard let soundFileURL = Bundle.main.url(
    //            forResource: "invalid", withExtension: "mp3"
    //        ) else {
    //            print("ERRORAUDIO NOT FOUND!")
    //            return
    //        }
    //        self.audioPlayer.startPlayback(audio: soundFileURL)
    //
    //    }
    
    
    
}


