//
//  SignListView.swift
//  KulingensApp
//
//  Created by Toni Löf on 2022-01-25.
//

import SwiftUI

struct SignListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Sign.name, ascending: true)],
        animation: .default)
    private var signs: FetchedResults<Sign>
    
    @Binding var activeSign: Sign?
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        VStack{
            List() {
                
                ForEach(signs) { sign in
                    Text(sign.name!)
                        .onAppear(perform: {
                       
                        
                            
                        })
                        .onTapGesture {
                            activeSign = sign
                            presentationMode.wrappedValue
                                .dismiss()
                        }
//                    NavigationLink(destination: VehicleView(vehicle: vehicle)) {
//                        RowView(vehicle: vehicle)
//                    }
                    
                }
            }
        }
    }
}

//struct SignListView_Previews: PreviewProvider {
//    static var previews: some View {
//        SignListView()
//    }
//}
