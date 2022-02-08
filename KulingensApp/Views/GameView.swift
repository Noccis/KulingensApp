//
//  GameView.swift
//  KulingensApp
//
//  Created by Toni Löf on 2022-02-03.
//

import SwiftUI

struct GameView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Sign.name, ascending: true)],
        animation: .default)
    private var signs: FetchedResults<Sign>
    
    var sign: Sign? = nil
    @State var videoUrl = "07d2dXHYb94"
    @State var audioUrlOne = ""
    @State var audioUrlTwo = ""
    @State var audioUrlThree = ""
    @State var rightAudioUrl = ""
    @State var audioPlayer = AudioPlayer()
    @State var audioRecorder = AudioRecorder()
    
    var body: some View {
        VStack{
            
            HStack{
                //        Spacer()
                
                
                
            }
            .frame(width: UIScreen.main.bounds.width, height: 30)
            .background(Color(red: 92/256, green: 177/256, blue: 199/256))
            Spacer()
            
            HStack{
                
                VideoView(videoID: videoUrl)
                    .frame(minWidth: 200, maxWidth: 600, minHeight: 100, maxHeight: 400)
                    .padding(EdgeInsets(top:0, leading: 30, bottom: 10, trailing: 0))
                
                VStack{
                    Text("LYSSNA:")
                        .bold()
                    Button(action: {
                      //  playAudio(audioName: rightAudioUrl)
                        audioUrlOne = signs[0].audioName!
                       playAudio(audioName: audioUrlOne)
                    }, label: {
                        HStack{
                            Image(systemName: "speaker.wave.3.fill")
                               // .padding()
                            Text("1")
                                .bold()
                                .font(.title2)
                                
                        }
                        .padding()
                        .foregroundColor(Color.black)
                        .background(Color(red: 92/256, green: 177/256, blue: 199/256 ))
                        .cornerRadius(10)
                        
                        
                    })
                        .padding()
                    
                    Button(action: {
                        playAudio(audioName: audioUrlTwo)
                    }, label: {
                        HStack{
                            Image(systemName: "speaker.wave.3.fill")
                               // .padding()
                            Text("2")
                                .bold()
                                .font(.title2)
                                
                        }
                        .padding()
                        .foregroundColor(Color.black)
                        .background(Color(red: 92/256, green: 177/256, blue: 199/256 ))
                        .cornerRadius(10)
                    })

                    Button(action: {
                        playAudio(audioName: audioUrlThree)
                    }, label: {
                        HStack{
                            Image(systemName: "speaker.wave.3.fill")
                               // .padding()
                            Text("3")
                                .bold()
                                .font(.title2)
                                
                        }
                        .padding()
                        .foregroundColor(Color.black)
                        .background(Color(red: 92/256, green: 177/256, blue: 199/256 ))
                        .cornerRadius(10)
                        
                        
                    })
                        .padding()
                }
                .padding(.leading, 30)
                
                
                
            }
            //  .background(Color(red: 150/256, green: 100/256, blue: 199/256))
            Spacer()
            HStack{
                
                VStack {
                    
                    Text("SVARA:")
                        .foregroundColor(Color.white)
                        .font(.title)
                        .bold()
                        .padding(EdgeInsets(top:20, leading: 0, bottom: 0, trailing: 0))
                    HStack {
                        
                        
                        Button(action: {
                            randomSign()
                            print("button one")
                        }, label: {
                            
                            Text("1")
                                .font(.title2)
                            
                        })
                            .padding(EdgeInsets(top:10, leading: 40, bottom: 20, trailing: 40))
                            .foregroundColor(Color.white)
                            .background(Color(red: 2/256, green: 116/256, blue: 138/256))
                            .cornerRadius(15)
                            .padding(EdgeInsets(top:20, leading: 60, bottom: 30, trailing: 0))
                        Spacer()
                        Button(action: {
                            print("button two")
                        }, label: {
                            Text("2")
                                .font(.title2)
                        })
                            .padding(EdgeInsets(top:20, leading: 40, bottom: 20, trailing: 40))
                            .foregroundColor(Color.white)
                            .background(Color(red: 2/256, green: 116/256, blue: 138/256))
                            .cornerRadius(15)
                        Spacer()
                        Button(action: {
                            print("button three")
                        }, label: {
                            Text("3")
                                .font(.title2)
                        })
                            .padding(EdgeInsets(top:20, leading: 40, bottom: 20, trailing: 40))
                            .foregroundColor(Color.white)
                            .background(Color(red: 2/256, green: 116/256, blue: 138/256))
                            .cornerRadius(15)
                            .padding(.trailing, 60)
                        
                        
                        
                        
                        
                        
                        
                        
                    }
                    
                }
                
            }
            .background(Color(red: 10/256, green: 177/256, blue: 200/256))
            
            
            
            
        }
        .background(Color(red: 210/256, green: 231/256, blue: 238/256 ))
        // .navigationBarHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing, content: {
                
                Image(systemName: "questionmark.circle.fill")
                
            })
        }
    }
    
    func randomSign() {
        if let randomSign = signs.randomElement() {
            
            guard let url = randomSign.videoUrl else {return}
            videoUrl = url                                          // VideoUrl är satt
            
            guard let audio = randomSign.audioName else {return}
     
        }
    }
    
    private func randomNrRightAnswer()-> Int {
        return Int.random(in: 1...3)
    }
    
    
    func playAudio(audioName: String) {
        
      let audioPath = fetchaudioUrl(audioName: audioName)
        
        guard let audioPath = audioPath else {
            return
        }

            if let audioUrl = URL(string: audioPath){

                self.audioPlayer.startPlayback(audio: audioUrl)

            }
        
    }
    
    private func fetchaudioUrl(audioName: String)-> String? {
    
        let audioList = self.audioRecorder.recordings

        for recording in audioList {
            let dodo = recording.fileURL.absoluteString.suffix(24)
            
            if dodo == audioName {
                
                print("FETCHAUDIOURL url found: ::\(recording.fileURL)::")
                return String(recording.fileURL.absoluteString)
            }
            
        }
            
        return nil
    }
//    func fetchSignAudio(){
//
//        if let activeSign = activeSign {
//            if let name = activeSign.audioName {
//                //  print("1 FETCHSIGN NAME:\(name):: COUNT:::\(name.count)")
//                if name.count > 1 {
//                    audioString = name
//                    //            print("2 AUDIOSTRING:::: \(audioString)")
//                }else{
//                    //         print("AUDIOSTRING SHOULD BE EMPTY")
//                    audioString = ""
//                    audioUrl = ""
//                }
//            }
//        }
//        // Behöver jag kalla på fetch recordings första gången appen körs?
//        let testList = self.audioRecorder.recordings
//
//        for recording in testList {
//            let dodo = recording.fileURL.absoluteString.suffix(24)
//            //  print("TESTLIST ::\(dodo)::")
//
//            if dodo == audioString {
//                //     print("PLaying!!!!!!!!!")
//                //     print("FETCHSIGNRECORDING DODO IS SAME AS IN LIST! set: ::\(audioUrl)::")
//                audioUrl = String(recording.fileURL.absoluteString)
//
//
//                //  self.audioPlayer.startPlayback(audio: recording.fileURL)
//            }
//        }
//    }
    
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}
