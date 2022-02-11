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
    
    
    @State var answerAnimation = false
    @State var answerIsRight = false
    @State var answerIsWrong = false
    @State var gameIsOn = true
    @State var gameInfoShowing = false
    @State var videoUrl = ""
    @State var audioUrlOne = ""
    @State var audioUrlTwo = ""
    @State var audioUrlThree = ""
    @State var rightAudioUrl = ""
    @State var answerOneString = ""
    @State var answerTwoString = ""
    @State var answerThreeString = ""
    @State var audioPlayer = AudioPlayer()
    @State var audioRecorder = AudioRecorder()
    @State var color = Color(red: 10/256, green: 177/256, blue: 200/256)
    
    var body: some View {
        VStack{
            
            HStack{
                NavigationLink(destination: GameInfoView(), isActive: self.$gameInfoShowing){
                    EmptyView()
                        .frame(width: 0, height: 0)
                        .disabled(true)
                }
                
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
                            checkAnswer(answer: answerOneString)
                        }, label: {
                            
                            Text("1")
                                .bold()
                                .font(.title2)
                                .frame(width: 100, height: 60)
                                .foregroundColor(Color.white)
                                .background(Color(red: 2/256, green: 116/256, blue: 138/256))
                                .cornerRadius(15)
                            
                        })
                        
                            .padding(EdgeInsets(top:0, leading: 60, bottom: 40, trailing: 0))
                        
                        Spacer()
                        
                        Button(action: {
                            checkAnswer(answer: answerTwoString)
                        }, label: {
                            Text("2")
                                .bold()
                                .font(.title2)
                                .frame(width: 100, height: 60)
                                .foregroundColor(Color.white)
                                .background(Color(red: 2/256, green: 116/256, blue: 138/256))
                                .cornerRadius(15)
                        })
                            .padding(.bottom, 40)
                        
                        Spacer()
                        
                        Button(action: {
                            checkAnswer(answer: answerThreeString)
                        }, label: {
                            Text("3")
                                .bold()
                                .font(.title2)
                                .frame(width: 100, height: 60)
                                .foregroundColor(Color.white)
                                .background(Color(red: 2/256, green: 116/256, blue: 138/256))
                            .cornerRadius(15)                        })
                        
                            .padding(EdgeInsets(top: 0, leading: 0, bottom: 40, trailing: 60))
                        
                    }
                    
                }
                
            }
            .background(color)
            
            
            
            
        }
        .background(Color(red: 210/256, green: 231/256, blue: 238/256 ))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: Button(action:{
            self.gameInfoShowing = true
            
        }) {
            
            Image(systemName: "questionmark.circle.fill")
                .resizable()
                .frame(width: 30, height: 30)
            
        })
        
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
                answerOneString = audio
                print("PICKRANDOMSIGN right audiourl is in 1")
            }else if randomNr == 2 {
                audioUrlTwo = audio
                answerTwoString = audio
                print("PICKRANDOMSIGN right audiourl is in 2")
            }else if randomNr == 3 {
                audioUrlThree = audio
                answerThreeString = audio
                print("PICKRANDOMSIGN right audiourl is in 3")
            }else{
                print("PICKRANDOMSIGN RANDOMNR ERROR")
            }
        }
        setTwoWrongAudioStrings()
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
    
    private func setTwoWrongAudioStrings(){
        
        if !audioUrlOne.isEmpty {       // Om rightaudio är på spelare 1
            
            audioUrlTwo = getRandomWrongAudioString()
            answerTwoString = audioUrlTwo
            audioUrlThree = getRandomWrongAudioString()
            answerThreeString = audioUrlThree
            
        }else if !audioUrlTwo.isEmpty {     // Om rightaudio är på spelare 2
            audioUrlOne = getRandomWrongAudioString()
            answerOneString = audioUrlOne
            audioUrlThree = getRandomWrongAudioString()
            answerThreeString = audioUrlThree
            
        }else if !audioUrlThree.isEmpty {       // Om rightaudio är på spelare 3
            audioUrlOne = getRandomWrongAudioString()
            answerOneString = audioUrlOne
            audioUrlTwo = getRandomWrongAudioString()
            answerTwoString = audioUrlTwo
            
        }
    }
    
    private func resetGame() {
        
        answerAnimation = false
        answerIsRight = false
        answerIsWrong = false
        videoUrl = ""
        audioUrlOne = ""
        audioUrlTwo = ""
        audioUrlThree = ""
        rightAudioUrl = ""
        answerOneString = ""
        answerTwoString = ""
        answerThreeString = ""
    }
    
    
    private func getRandomWrongAudioString()-> String {
        print("RANDOMWRONGAUDIO RUNNING!")
        var audioString = ""
        if let randomSign = signs.randomElement() {
            
            var wrongAudio = randomSign.audioName
            
            while wrongAudio == rightAudioUrl{
                print("RANDOM-WRONG-AUDIO wrong is same as right")
                
                if let newSign = signs.randomElement() {
                    wrongAudio = newSign.audioName
                    
                }
            }
            
            guard let wrongAudio = wrongAudio else {return "Nope"}
            
            audioString = wrongAudio
        }
        return audioString
    }
    
    private func checkAnswer(answer: String) {
        if answer == rightAudioUrl{
            showAnswerIsRightColor()
            playRightAnswerSound()
            resetGame()
            pickRandomSign()
        }else{
            showAnswerIsWrongColor()
            playWrongAnswerSound()
        }
        
    }
    
    private func showAnswerIsRightColor() {
        
        withAnimation(.easeInOut(duration: 0.1)){
            color = Color(red: 0/256, green: 255/256, blue: 0/256)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            withAnimation(.easeInOut(duration: 0.3)){
                color = Color(red: 10/256, green: 177/256, blue: 200/256)
            }
        }
    }
    
    private func showAnswerIsWrongColor() {
        
        withAnimation(.easeInOut(duration: 0.1)) {
            color = Color(red: 255/256, green: 31/256, blue: 0/256)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeInOut(duration: 0.3)) {
                color = Color(red: 10/256, green: 177/256, blue: 200/256)
            }
        }
    }
    
    private func playWrongAnswerSound() {
        
        guard let soundFileURL = Bundle.main.url(
            forResource: "wronganswer2", withExtension: "mp3"
        ) else {
            print("ERRORAUDIO NOT FOUND!")
            return
        }
        self.audioPlayer.startPlayback(audio: soundFileURL)
        
        
    }
    
    private func playRightAnswerSound() {
        
        guard let soundFileURL = Bundle.main.url(
            forResource: "correctanswer", withExtension: "mp3"
        ) else {
            print("ERRORAUDIO NOT FOUND!")
            return
        }
        self.audioPlayer.startPlayback(audio: soundFileURL)
        
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
