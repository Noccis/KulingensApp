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
    
    @State var inputName: String = ""
    @State var inputVideoUrl: String = ""
    
    @Environment(\.presentationMode) var presentationMode
    
    
    var body: some View {
        
        VStack{
            
        Text("Skapa nytt tecken")
                .padding()
   //         Spacer()
//            HStack{
//            Text("Namge ditt tecken:")
//                Spacer()
//            }
            .padding()                                  // Ta bort padding neråt
            TextField("Namge ditt tecken", text: $inputName)             // Ta bort padding uppåt
                .padding()
                .background(Color.gray.opacity(0.2).cornerRadius(10))
                .font(.title3)
                .padding()
            

            
            TextField("Skriv in URL till din video", text: $inputVideoUrl)
                .padding()
                .background(Color.gray.opacity(0.2).cornerRadius(10))
                .font(.title3)
                .padding()
            
//            Text("Här kan man spela in ljud")
//                .padding()
//
            Spacer()
            
            Button(action: {
                addSign()
                presentationMode.wrappedValue
                    .dismiss()
            }, label: {
                Text("Spara")
            })
            Spacer()
            
        }
    }
    
    private func addSign() {
        withAnimation {
            
            if inputName.count > 3 && inputVideoUrl.count > 5 {
                
                let newSign = Sign(context: viewContext)
                // Lägg till lite nil checks
                
                newSign.name = inputName
                
                newSign.videoUrl = inputVideoUrl
                
                do {
                    try viewContext.save()
                    
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nsError = error as NSError
                    fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
                }
            }else{
                print("Error saving! Name not long enough")
                // Lägg in en toast.
            }
            
            inputName = ""
        
            
            inputVideoUrl = ""
            print("Nytt tecken sparat!")
        }
    }
    
    
    
}

//struct CreateSignView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreateSignView()
//    }
//}
