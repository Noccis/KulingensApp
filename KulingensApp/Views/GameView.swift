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
    var videoUrl = ""
    var audioUrlOne = ""
    var audioUrlTwo = ""
    var audioUrlThree = ""
    var rightAudioUrl = ""
    
    
    var body: some View {
        VStack{
            // Video
            HStack{
                Spacer()
                Image(systemName: "questionmark.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .padding(EdgeInsets(top:0, leading: 0, bottom: 15, trailing: 15))
                    
                // , alignment: .trailing
                
               // Text("Tillbaka")
               // Spacer()
            
            }
            .frame(width: UIScreen.main.bounds.width, height: 30)
           .background(Color(red: 92/256, green: 177/256, blue: 199/256))
           Spacer()
            
            HStack{
               
                Text("Video")
                    .padding(.leading, 30)
                Spacer()
                VStack{
                    Text("Audio 1")
                        .padding()
                    Text("Audio 2")
                        .padding()
                    Text("Audio 3")
                        .padding()
                    
                }
                .padding(.trailing, 30)
                
             
                
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
    }
    
    func randomSign() {
        
        // Gör random nr upp till signs.count
        // Ta ut sign så den blir signs.[randomnr]
        // Sätt videoUrl och name (eller audio)
        //
        
        
    }
}

//struct GameView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameView()
//    }
//}
