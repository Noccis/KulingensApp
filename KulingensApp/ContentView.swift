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
    @State var isMenuActive = false
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
                Button(action: {
                    isMenuActive = true
                }, label: {
                    Text("Byt tecken")
                        .foregroundColor(Color.white)
                })
                    .padding()

            }
            .cornerRadius(15)
            .background(Color(red: 2/256, green: 116/256, blue: 138/256 ))
            .padding()
            
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
                    
                    
                }
                Spacer()
            }else{
                
                Text ("Det finns inga tecken att visa.")
                Text("Skapa ett nytt genom att trycka på plus tecknet uppe i menyn.")
                
            }
            
        }
        .sheet(isPresented: $createViewIsActive) { CreateSignView() }
        .sheet(isPresented: $isMenuActive) { SignListView(activeSign: activeSign) }
        
        
        
        
        
    }
    
    private func addSign() {
        withAnimation {
            let newSign = Sign(context: viewContext)
            newSign.name = "Klogli"
            
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
