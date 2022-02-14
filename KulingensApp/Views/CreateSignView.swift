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
        
        HStack{
            Button(action: {
                presentationMode.wrappedValue
                    .dismiss()
            }, label: {
                Text("Avbryt")
                    .padding()
                    .font(.title3)
                    .foregroundColor(Color.red)
                    .cornerRadius(15)
            })
            Spacer()
        }
        VStack{
            
            Text("Skapa nytt tecken")
                .font(.title)
                .padding()
            
                .padding()                                  // Ta bort padding neråt
            TextField("Namge ditt tecken", text: $inputName)             // Ta bort padding uppåt
                .padding()
                .background(Color.gray.opacity(0.2).cornerRadius(10))
                .font(.title3)
                .padding()
            
            
            
            TextField("Skriv in ID till din video", text: $inputVideoUrl)
                .padding()
                .background(Color.gray.opacity(0.2).cornerRadius(10))
                .font(.title3)
                .padding()
            
            Text("Spela in ljud")
                .font(.title)
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
            
            Spacer()
            
            Text(varningText)
                .foregroundColor(Color.red)
                .padding()
            Button(action: {
                
                if stopAudio == true {
                    varningText = "Stoppa audioinspelningen innan du sparar"
                    saveText = "Spara"
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
                    .font(.title2)
                    .padding()
                    .foregroundColor(Color.white)
                    .background(Color(red: 92/256, green: 177/256, blue: 199/256))
                    .cornerRadius(15)
            })
            Spacer()
            
        }
        
    }
    
    private func addSign() {
        withAnimation {
            if inputName.count > 2 && inputVideoUrl.count > 2 {
                
                let newSign = Sign(context: viewContext)
                // Lägg till lite nil checks
                
                newSign.name = inputName
                
                newSign.videoUrl = inputVideoUrl
                
                newSign.audioName = inputAudioName
                
                activeSign = newSign
                
                do {
                    try viewContext.save()
                    
                } catch {
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }else{
                print("För kort namn")
            }
            
            inputName = ""
            inputVideoUrl = ""
            
            
        }
    }
    
}



//struct CreateSignView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateSignView()
//    }
//}

