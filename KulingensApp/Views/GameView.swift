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
    var  rightName = ""
    var wrongNameOne = ""
    var wrongNameTwo = ""
    
    
    var body: some View {
        VStack{
            // Video
            HStack{
                
                Text("Bullets.")
            
            }
            .background(Color(red: 2/256, green: 116/256, blue: 138/256 ))

            
            
            
        }
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
