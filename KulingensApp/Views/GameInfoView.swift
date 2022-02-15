//
//  GameInfoView.swift
//  KulingensApp
//
//  Created by Toni Löf on 2022-02-10.
//

import SwiftUI
import AVKit

struct GameInfoView: View {
    
  
    let practiceVideo = "practise"
    
    
    var body: some View {
        HStack{
            
        }
        .frame(width: UIScreen.main.bounds.width, height: 30)
        .background(Color(red: 92/256, green: 177/256, blue: 199/256))
        
        ScrollView {
            VStack(alignment: .leading) {
                
                Text("För att öva på tecken:")
                    .font(.title)
                    .padding()
                    .frame(maxWidth: .infinity)
                
                VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: practiceVideo, withExtension: "mov")!))
                    .frame(width: 400, height: 500, alignment: .center)
                    .padding()
                Text("På skärmen ser du en video med ett tecken. \nTill höger om videon kan du lyssna på 3 olika ljud. Ett av dom ljudet är vad som tecknas i videon. \nNär du vet vilket ljud som är rätt trycker du på rätt siffra under videon och svara texten. \nOm du har svarat rätt laddas en ny video. Om du har svarat fel får du försöka igen.")
                    .padding()
                
            }
            
        }
        
    }
}

//struct GameInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        GameInfoView()
//    }
//}
