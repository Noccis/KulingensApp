//
//  CreateSignView.swift
//  KulingensApp
//
//  Created by Toni Löf on 2022-01-19.
//

import SwiftUI

struct CreateSignView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Sign.name, ascending: true)],
        animation: .default)
    private var signs: FetchedResults<Sign>
    
    @ObservedObject var audioRecorder: AudioRecorder
    @State var inputName: String = ""
    @State var inputVideoUrl: String = ""
    @State var inputAudioName: String = ""
    @Binding var activeSign: Sign?
    @State var isAudioSaved = false
    @State var varningText = ""
    @State var saveText = "Spara"
    @State var stopAudio = false
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        NavigationView{
            VStack{
                
                Text("Skapa nytt tecken")
                    .padding()
                
                    .padding()                                  // Ta bort padding neråt
                TextField("Namge ditt tecken", text: $inputName)             // Ta bort padding uppåt
                    .padding()
                    .background(Color.gray.opacity(0.2).cornerRadius(10))
                    .font(.title3)
                    .padding()
                
                
                
                TextField("Skriv in URL till din video", text: $inputVideoUrl)
                    .padding()
                    .background(Color.gray.opacity(0.2).cornerRadius(10))
                    .font(.title3)
                    .padding()
                
                Text("Här kan man spela in ljud")
                    .padding()
                if audioRecorder.recording == false {
                    Button(action: {
                        inputAudioName = self.audioRecorder.startRecording()
                        stopAudio = true
                    }) {
                        Image(systemName: "circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                } else {
                    Button(action: {
                        self.audioRecorder.stopRecording()
                        isAudioSaved = true
                        stopAudio = false
                    }) {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 50, height: 50)
                            .clipped()
                            .foregroundColor(.red)
                            .padding(.bottom, 40)
                    }
                }
                
                //  Lista med recordings
                //   RecordingsList(audioRecorder: audioRecorder)
                
                
                Spacer()
                Text(varningText)
                    .foregroundColor(Color.red)
                    .padding()
                Button(action: {
                    
                    if stopAudio == true {
                        varningText = "Stoppa audioinspelningen innan du sparar"
                    }else{
                        if isAudioSaved == true {
                            addSign()
                            presentationMode.wrappedValue
                                .dismiss()
                        }else{
                            varningText = "Du har inte spelat in ljud till ditt tecken. Är du säker på att du vill spara?"
                            isAudioSaved = true
                            saveText = "Ja, spara"
                        }
                    }
                }, label: {
                    Text(saveText)
                })
                Spacer()
                
            }
            .navigationBarTitle("Just nu bara")
            
        }
        
        
    }
    
    private func addSign() {
        
        
        
        withAnimation {
            if inputName.count > 3 && inputVideoUrl.count > 5 {
                
                let newSign = Sign(context: viewContext)
                // Lägg till lite nil checks
                
                newSign.name = inputName
                
                newSign.videoUrl = inputVideoUrl
                
                newSign.audioName = inputAudioName
                
                //    print ("\(inputName) har audio:: \(inputAudioName)")
                activeSign = newSign
                
                do {
                    try viewContext.save()
                    
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }else{
                print("Error saving! Name not long enough")
                //   varningText = "Du har inte lagt till ljud, är du säker på att du vill spara?"
                // Lägg in en toast.
            }
            
            inputName = ""
            inputVideoUrl = ""
            
            
        }
    }
    
}

struct RecordingsList: View {
    
    @ObservedObject var audioRecorder: AudioRecorder
    
    var body: some View {
        List {
            ForEach(audioRecorder.recordings, id: \.createdAt) { recording in
                RecordingRow(audioURL: recording.fileURL)
            }
            .onDelete(perform: delete)
        }
    }
    
    func delete(at offsets: IndexSet) {
        var urlsToDelete = [URL]()
        for index in offsets {
            urlsToDelete.append(audioRecorder.recordings[index].fileURL)
        }
        audioRecorder.deleteRecording(urlsToDelete: urlsToDelete)
    }
}

struct RecordingRow: View {
    
    var audioURL: URL
    @ObservedObject var audioPlayer = AudioPlayer()
    
    var body: some View {
        HStack {
            Text("\(audioURL.lastPathComponent)")
            Spacer()
            if audioPlayer.isPlaying == false {
                Button(action: {
                    self.audioPlayer.startPlayback(audio: self.audioURL)
                }) {
                    Image(systemName: "play.circle")
                        .imageScale(.large)
                }
            } else {
                Button(action: {
                    self.audioPlayer.stopPlayback()
                }) {
                    Image(systemName: "stop.fill")
                        .imageScale(.large)
                }
            }
        }
    }
}

//struct CreateSignView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateSignView()
//    }
//}

