//
//  Community_Run_BoardApp.swift
//  Community Run Board
//
//  Created by Anthony Mac on 2022-06-10.
//

import SwiftUI

@main
struct Community_Run_BoardApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
