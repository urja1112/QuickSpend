//
//  QuickspendApp.swift
//  Quickspend
//
//  Created by urja 💙 on 2025-04-12.
//

import SwiftUI

@main
struct QuickspendApp: App {
    @StateObject private var datacontroller = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,datacontroller.container.viewContext)
        }
    }
}
