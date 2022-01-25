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
    @State private var isLocked = true
    @State var createViewIsActive = false
    @State var activeSign: Sign? = nil
    private var pinCode: Int? = nil
    
    
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
              
                    
                    Text("Searchfunction")
                        .foregroundColor(Color.white)
                        .padding()
                    Spacer()
                    Button(action: {
                        createViewIsActive = true
                        
                    }, label: {
                        Text("Nytt tecken")
                            .foregroundColor(Color.white)
                            .onAppear {
                                
                                if signs.count != 0 {
                                    
                                    activeSign = signs[0]
                                    
                                    
                                }
                            }
//                        Image(systemName: "plus")
//                            .foregroundColor(Color.white)
                    })
                        .padding()
                if isLocked == false {
                    Button(action: {
                        deleteItems()
                    }, label: {
                        Text("Delete")
                    })
                }
                    Spacer()
                    Button(action: {
                        isLocked.toggle()
                    }, label: {
                        Image(systemName: isLocked ? "lock.fill" : "lock.open.fill")
                    })
                Spacer()

            }
            .background(Color.gray)
            .padding()
            
            DisclosureGroup("Tecken", isExpanded: $isExpanded) {
                ScrollView{
                    VStack{
                        ForEach(signs, id: \.self) { sign in
                            HStack{
                                Text(sign.name!)
                                    .font(.title3)
                                    .padding(.all)
                                    .onTapGesture {
                                        self.isExpanded.toggle()
                                        self.activeSign = sign
                                    }
                            }
                            
                        }
                    }
                }
            }
            .accentColor(.white) // Arrow color
            .font(.title3)
            .foregroundColor(.white) // Text color
            .padding(.all)
            .cornerRadius(8)
            .frame(minWidth: 10, maxWidth: 300)
            
            
            Spacer()
            
            
            if let activeSign = activeSign {
                HStack{
                    
                    Text(activeSign.name!)
                        .padding()
                    Spacer()
                    Text("Audio file")
                        .padding(.trailing, 300)
                    
                }
                
                
                HStack{
                    VideoView(videoID: activeSign.videoUrl!)
                        .frame(minWidth: 200, maxWidth: 600, minHeight: 100, maxHeight: 400)
                        .padding()
                    Spacer()
                    
                    VStack{ // Room for instruction
                        Text(activeSign.instruction!)
                            .padding(.trailing, 200)
                        //    Spacer()
                    }
                    
                }
                Spacer()
            }else{
                
                Text ("Det finns inga tecken att visa.")
                Text("Skapa ett nytt genom att trycka på plus tecknet uppe i menyn.")
                
            }
            
        }
        .sheet(isPresented: $createViewIsActive) { CreateSignView() }
        
        
        
        
        
        
    }
    
    private func addSign() {
        withAnimation {
            let newSign = Sign(context: viewContext)
            newSign.name = "Klogli"
            newSign.instruction = "Second gen."
            
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
    
    private func deleteItems() {
        
        guard let activeSign = activeSign else {
            return
        }
        
        viewContext.delete(activeSign)
        print(signs.count)
        self.activeSign = nil
        
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
