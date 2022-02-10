//
//  GameInfoView.swift
//  KulingensApp
//
//  Created by Toni Löf on 2022-02-10.
//

import SwiftUI

struct GameInfoView: View {
    
    
    var body: some View {
        HStack{
            
        }
        .frame(width: UIScreen.main.bounds.width, height: 30)
        .background(Color(red: 92/256, green: 177/256, blue: 199/256))
        
        ScrollView {
            VStack {
                
                Text("Såhär övar du på tecken:")
                    .font(.title)
                
            }
            
        }
        
    }
}

struct GameInfoView_Previews: PreviewProvider {
    static var previews: some View {
        GameInfoView()
    }
}
