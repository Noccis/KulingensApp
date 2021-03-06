//
//  mainInfoView.swift
//  KulingensApp
//
//  Created by Toni Löf on 2022-02-10.
//

import SwiftUI
import AVKit

struct mainInfoView: View {
    let lockImage = UIImage(named: "lock")
    let createOne = UIImage(named: "create")
    let createTwo = UIImage(named: "createtwo")
    let youTubeId = UIImage(named: "youtubeid")
    let youtubeVideo = "youtubeid"
    let createvideo = "createsign"
    
    
    var body: some View {
        HStack{
            
        }
        .frame(width: UIScreen.main.bounds.width, height: 30)
        .background(Color(red: 92/256, green: 177/256, blue: 199/256))
        
        
        ScrollView{
            
            VStack(alignment: .leading, spacing: 10){
                
                Text("Såhär använder du Kulingens app:")
                    .font(.title)
                    .padding(30)
                    .foregroundColor(Color.black)
                    .frame(maxWidth: .infinity)
                Image(uiImage: lockImage!)
                
                Text("För att låsa upp funktionerna skapa och radera tecken, tryck på låsknappen.")
      
                VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: youtubeVideo, withExtension: "mov")!))
                    .frame(minWidth: 200, maxWidth: 400, minHeight: 100, maxHeight: 200)
                    .padding(.top, 20)
                Text("För att skapa ett nytt tecken, se först till att du har kopierat ID på den youtube film du vill visa. \nDu ska INTE kopiera hela länken till filmen utan endast den bit av texten som är efter = tecknet. Se video ovan.")
                
                VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: createvideo, withExtension: "mov")!))
                    .frame(width: 400, height: 500, alignment: .center)
                    .padding(.top, 20)
                Text("Klicka på Nytt tecken.")
                
                Text("Fyll i namn på ditt tecken och lägg sedan in video id för den video från youtube du vill visa.")
                
                Text("För att spela in ljud till ditt tecken tryck på spela in knappen, vänta tills knappen blivit en fyrkant sen kan du prata. \nTryck på fyrkanten när du är klar och ljudet är sparat. \nFör att spara hela tecknet tryck på spara längst ner på skärmen.")
                
                    .padding(.bottom, 50)
                
                
                
            }
            .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
            
        }
        .navigationBarTitleDisplayMode(.inline)
        
    }
}




//struct mainInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        mainInfoView()
//    }
//}
