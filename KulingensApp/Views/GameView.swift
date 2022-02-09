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
    
    //  var sign: Sign? = nil
    @State var answerAnimation = false
    @State var answerIsRight = false
    @State var answerIsWrong = false
    @State var gameIsOn = true
    @State var videoUrl = ""
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
            
            if gameIsOn == true {
                
                ZStack{
                   
                    HStack{
                        
                        VideoView(videoID: videoUrl)
                            .frame(minWidth: 200, maxWidth: 600, minHeight: 100, maxHeight: 400)
                            .padding(EdgeInsets(top:0, leading: 30, bottom: 10, trailing: 0))
                            .onAppear(perform: {
                                pickRandomSign()
                            })
                        
                        VStack{
                            Text("LYSSNA:")
                                .bold()
                            Button(action: {
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
                    if answerIsRight == true {
                        
                        Text("Rätt svar!")
                            .font(.largeTitle)
                            .padding(100)
                            .background(Color.green)
                            .cornerRadius(15)
                            .onAppear() {
                                withAnimation(Animation
                                                .easeInOut(duration: 3.2), {
                                    print("BEFORE\(answerAnimation)")
                                    answerAnimation.toggle()
                                    print("AFTER\(answerAnimation)")
                                })
                            }.opacity(answerAnimation ? 0 : 1)
                        
                    }
                    if answerIsWrong == true {
                        Text("Fel, Försök igen.")
                            .font(.largeTitle)
                            .padding(100)
                            .background(Color.red)
                            .cornerRadius(15)
                            .onAppear() {
                                withAnimation(Animation
                                                .easeInOut(duration: 3.2), {
                                  
                                    answerAnimation.toggle()
                                   
                                })
                            }.opacity(answerAnimation ? 0 : 1)
                        
                    }
                }
                
                
                
                
                
                
            }else{
                Text("Minst 3 tecken behöver vara sparade för att öva. Gå tillbaka och spela in flera tecken.")
            }
            
            Spacer()
            HStack{
                
                VStack {
                    
                    Text("SVARA:")
                        .foregroundColor(Color.white)
                        .font(.title)
                        .bold()
                        .padding(EdgeInsets(top:20, leading: 0, bottom: 0, trailing: 0))
                        .onAppear(perform: {
                            checkThatListIsNotEmpty()
                        })
                    HStack {
                        
                        
                        Button(action: {
                            showAnswerIsWrongText()
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
    
    func pickRandomSign() {
        print("PICKRANDOMSIGN RUNNING!!!")
        if let randomSign = signs.randomElement() {
            
            guard let url = randomSign.videoUrl else {return}
            videoUrl = url                                          // VideoUrl är satt
            
            guard let audio = randomSign.audioName else {
                print("ERROR ---- PICKRANDOMSIGN randomSign.audioName is NIL")
                return
            }
            
            
            print("Right audio Name::::::: \(audio)")
            rightAudioUrl = audio
            let randomNr = Int.random(in: 1...3)
            
            if randomNr == 1 {
                audioUrlOne = audio
                print("PICKRANDOMSIGN right audiourl is in 1")
            }else if randomNr == 2 {
                audioUrlTwo = audio
                print("PICKRANDOMSIGN right audiourl is in 2")
            }else if randomNr == 3 {
                audioUrlThree = audio
                print("PICKRANDOMSIGN right audiourl is in 3")
            }else{
                print("PICKRANDOMSIGN RANDOMNR ERROR")
            }
        }
        setTwoWrongAudioStrings()
    }
    
    //    private func randomNr()-> Int {
    //        return Int.random(in: 1...3)
    //    }
    
    
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
    
    private func setTwoWrongAudioStrings(){
        
        if !audioUrlOne.isEmpty {       // Om rightaudio är på spelare 1
            
            audioUrlTwo = getRandomWrongAudioString()
            audioUrlThree = getRandomWrongAudioString()
            
        }else if !audioUrlTwo.isEmpty {     // Om rightaudio är på spelare 2
            audioUrlOne = getRandomWrongAudioString()
            audioUrlThree = getRandomWrongAudioString()
            
        }else if !audioUrlThree.isEmpty {       // Om rightaudio är på spelare 3
            audioUrlOne = getRandomWrongAudioString()
            audioUrlTwo = getRandomWrongAudioString()
            
            
            
        }
        
        
        
    }
    
    
    private func getRandomWrongAudioString()-> String {
        print("RANDOMWRONGAUDIO RUNNING!")
        var audioString = ""
        if let randomSign = signs.randomElement() {
            
            var wrongAudio = randomSign.audioName
            
            while wrongAudio == rightAudioUrl{      // Kollar så inte right wrong audio är samma som right audio
                print("RANDOM-WRONG-AUDIO wrong is same as right")
                
                if let newSign = signs.randomElement() {
                    wrongAudio = newSign.audioName
                    
                }
            }               // wrong audio string är skapad
            
            guard let wrongAudio = wrongAudio else {return "Nope"}
            
            audioString = wrongAudio
        }
        return audioString
    }
    
    private func checkAnswer(answer: String) {
        if answer == rightAudioUrl{
            showANswerIsRightText()
            
        }else{
            
        }
        
    }
    
    private func showANswerIsRightText() {
        
        answerAnimation = false
        answerIsRight.toggle()
    }
    
    private func showAnswerIsWrongText() {
        answerAnimation = false
        answerIsWrong.toggle()
        
    }
    
    private func checkThatListIsNotEmpty() {
        if signs.count < 3 {
            gameIsOn = false
        }
    }
    
    
    
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}
