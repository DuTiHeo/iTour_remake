//
//  iTourApp.swift
//  iTour
//
//  Created by Macpro M2    on 2026/01/31.
//
import SwiftData
import SwiftUI

@main
struct iTourApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        //.modelContainer(for: Destination.self)
        .modelContainer(for: [Destination.self, Sight.self])
    }
}
