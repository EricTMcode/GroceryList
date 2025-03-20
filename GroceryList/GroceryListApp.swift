//
//  GroceryListApp.swift
//  GroceryList
//
//  Created by Eric on 20/03/2025.
//

import SwiftUI
import SwiftData

@main
struct GroceryListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Item.self)
        }
    }
}
