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
    
    
    var body: some View {
        
        VStack{
            
        Text("Skapa nytt tecken")
                .padding()
            Spacer()
            
            Text("Här ska man kunna skriva in namn på tecken")
                .padding()
            Text("Här skriver man instruktioner")
                .padding()
            Text("Här kopierar man in URL")
                .padding()
            Text("Här kan man spela in ljud")
                .onAppear{
                    print(signs)
                }
            Spacer()
            
        }
    }
    
    private func addSign() {
        withAnimation {
            let newSign = Sign(context: viewContext)
            newSign.name = "Nytt Sign"
            newSign.instruction = "Jag skapades i createSignView!"
            
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    
    
}

//struct CreateSignView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateSignView()
//    }
//}
