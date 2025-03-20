//
//  ContentView.swift
//  GroceryList
//
//  Created by Eric on 20/03/2025.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]


    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    Text(item.title)
                        .font(.title.weight(.light))
                        .padding(.vertical, 2)
                        .foregroundStyle(item.isCompleted == false ? Color.primary : Color.accentColor)
                        .strikethrough(item.isCompleted)
                        .italic(item.isCompleted)
                }
            }
            .navigationTitle("Grecery List")
            .overlay {
                if items.isEmpty {
                    ContentUnavailableView("Empty Cart", systemImage: "cart.circle", description: Text("Add some items to the shopping list."))
                }
            }
        }
    }
}

#Preview("List with Sample Data") {
    let sampleData: [Item] = [
        Item(title: "Milk", isCompleted: true),
        Item(title: "Butter", isCompleted: false),
        Item(title: "Breed", isCompleted: .random()),
        Item(title: "Coffee", isCompleted: .random()),
        Item(title: "Beer", isCompleted: .random())
        ]

    let container = try! ModelContainer(for: Item.self, configurations: ModelConfiguration(isStoredInMemoryOnly: true))

    for item in sampleData {
        container.mainContext.insert(item)
    }

    return ContentView()
        .modelContainer(container)

}

#Preview("Empty List") {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
