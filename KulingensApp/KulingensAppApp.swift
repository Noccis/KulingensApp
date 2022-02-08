//
//  KulingensAppApp.swift
//  KulingensApp
//
//  Created by Toni Löf on 2022-01-17.
//

import SwiftUI

@main
struct KulingensAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
         //   GameView()
        }
    }
}

// ContentView()
// CreateSignView()
