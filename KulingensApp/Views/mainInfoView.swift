//
//  mainInfoView.swift
//  KulingensApp
//
//  Created by Toni Löf on 2022-02-10.
//

import SwiftUI

struct mainInfoView: View {
    let lockImage = UIImage(named: "lock")
    // let createImage = UIImage(named: "create")
    
    
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
                    Image(uiImage: UIImage(named: "create")!)
                    Text("Clicka på Nytt tecken för att skapa ett nytt tecken.")
                    
                }
               // .background(Color(red: 210/256, green: 231/256, blue: 238/256 ))
                .frame(width: UIScreen.main.bounds.width)
                
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
