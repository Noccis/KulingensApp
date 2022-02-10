//
//  mainInfoView.swift
//  KulingensApp
//
//  Created by Toni Löf on 2022-02-10.
//

import SwiftUI

struct mainInfoView: View {
    let lockImage = UIImage(named: "lock")
    let createOne = UIImage(named: "create")
    let createTwo = UIImage(named: "createtwo")
    let youTubeId = UIImage(named: "youtubeid")
    
    
    var body: some View {
        HStack{
            //        Spacer()
            
            
            
        }
        .frame(width: UIScreen.main.bounds.width, height: 30)
        .background(Color(red: 92/256, green: 177/256, blue: 199/256))

        
            
            ScrollView{
                
                VStack(spacing: 20){
                    
                    Text("Såhär använder du Kulingens app:")
                        .font(.title)
                        .foregroundColor(Color.black)
                        .frame(maxWidth: .infinity)
                    Image(uiImage: lockImage!)
                    // Image(uiImage: UIImage(named: "lock")!)
                    Text("För att låsa upp funktionerna Skapa och radera tecken, tryck på lås.")
                    Image(uiImage: youTubeId!)
                    Text("För att skapa ett nytt tecken, se först till att du har kopierat ditt ID på den youtube film du vill visa. \nDu ska INTE kopiera hela länken till filmen utan endast den bit av texten som är efter = tecknet. Se bild ovan.")
                    Image(uiImage: createOne!)
                    Text("Klicka på Nytt tecken för att skapa ett nytt tecken.")
                    Image(uiImage: createTwo!)
                    Text("Fyll i namn på ditt tecken och lägg sedan in video id för den video från youtube du vill visa.")
                    Text("För att spela in ljud till ditt tecken tryck på spela in knappen, vänta tills knappen blivit en fyrkant sen kan du prata. \nTryck på fyrkanten när du är klar och ljudet är sparat. \nFör att spara hela tecknet tryck på spara längst ner på skärmen.")
                    
                    
                    
                }
               // .background(Color(red: 210/256, green: 231/256, blue: 238/256 ))
                .frame(width: UIScreen.main.bounds.width)
                .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
                
            }
            .navigationBarTitleDisplayMode(.inline)
           // .background(Color(red: 210/256, green: 231/256, blue: 238/256 ))
        
    }
    
    
}



//struct mainInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        mainInfoView()
//    }
//}
