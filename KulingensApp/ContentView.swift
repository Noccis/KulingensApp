//
//  ContentView.swift
//  KulingensApp
//
//  Created by Toni Löf on 2022-01-17.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Sign.name, ascending: true)],
        animation: .default)
    private var signs: FetchedResults<Sign>
    
    @State private var isExpanded = false
    
    
    
   // var signShowing: Sign
    
    //    init() {
           
    //
    //        let newSign = Sign(context: viewContext)
    //        newSign.name = "Dodo"
    //        newSign.instruction = "Hej och hå."
    //
    //        do {
    //            try viewContext.save()
    //        } catch {
    //
    //            let nsError = error as NSError
    //            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    //        }
   //     }
    
    var body: some View {
        
        
        
        VStack {
            HStack{
                Text("Här ska sökfunktionen vara.")
                    .foregroundColor(Color.white)
                    .padding()
                Spacer()
                Button(action: addSign, label: {
                    Text("Lägg till tecken.")
                        .foregroundColor(Color.white)
                    Image(systemName: "plus")
                        .foregroundColor(Color.white)
                })
                Spacer()
                
                DisclosureGroup("Tecken", isExpanded: $isExpanded) {
                    ScrollView{
                        VStack{
                            ForEach(signs) { sign in
                                HStack{
                                Text(sign.name!)
                                    .font(.title3)
                                    .padding(.all)
                                    Spacer()
                                        .font(.title2)
                                        .padding(.all)
                                        .onTapGesture {
                                            self.isExpanded.toggle()
                                        //    self.signShowing = sign
                                            
                                        }
                                }
                                
                            }
                        }
                    }
                }
                    .accentColor(.white) // Pil färg
                    .font(.title3)
                    .foregroundColor(.white) // Text färg
                    .padding(.all)
//                    .background(Color.blue) // Färg på hela drop down grejen
                    .cornerRadius(8)
                
                
            }
            .background(Color.gray)
            .padding()
            Spacer()
            

            
            if let activeSign = signs.first {
                Text(activeSign.name!)
                    .padding()
            }else{
                Text("Tecken Namn")
                    .padding()
            }
            
            if let activeSign = signs.first {
                Text(activeSign.instruction!)
                    .padding()
            }else{
                Text("Tecken instruktion.")
                    .padding()
            }
            
            Spacer()
            
        }
        
        
    }
    
    private func addSign() {
        withAnimation {
            let newSign = Sign(context: viewContext)
            newSign.name = "Dodo"
            newSign.instruction = "Hej och hå."
            
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
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { signs[$0] }.forEach(viewContext.delete)
            
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

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}


//        .onAppear(){
//            let newSign = Sign(context: viewContext)
//                    newSign.name = "Dodo"
//                    newSign.instruction = "Hej och hå."
//
//                    do {
//                        try viewContext.save()
//                    } catch {
//
//                        let nsError = error as NSError
//                        fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//                    }
//            print(signs)
//        }
//        NavigationView {
//            List {
//                ForEach(signs) { sign in
//                    NavigationLink { // Texten som visas efter man tryckt på objektet i listan.
//                        Text("Item name \(sign.name!)")
//                        Text("Instruction: \(sign.instruction!)")
//
//                    } label: {  // Texten som visas i listan.
//                        Text(sign.name!)
//
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addSign) {
//                        Label("Add Sign", systemImage: "plus")
//                    }
//                }
//            }
//            Text("Select an item")
//        }
//
