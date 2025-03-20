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

    @State private var item = ""

    private func addEssentialFoods() {
        modelContext.insert(Item(title: "Milk", isCompleted: true))
        modelContext.insert(Item(title: "Butter", isCompleted: false))
        modelContext.insert(Item(title: "Breed", isCompleted: .random()))
        modelContext.insert(Item(title: "Coffee", isCompleted: .random()))
        modelContext.insert(Item(title: "Beer", isCompleted: .random()))
    }

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
                        .swipeActions {
                            Button(role: .destructive) {
                                modelContext.delete(item)
                                try? modelContext.save()
                            } label: {
                                Label("Delete", systemImage: "trash")
                            }
                        }
                        .swipeActions(edge: .leading) {
                            Button("Done", systemImage: item.isCompleted == false ? "checkmark.circle" : "x.circle") {
                                item.isCompleted.toggle()
                                try? modelContext.save()
                            }
                            .tint(item.isCompleted == false ? .green : .accentColor)
                        }
                }
            }
            .navigationTitle("Grecery List")
            .toolbar {
                if items.isEmpty {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            addEssentialFoods()
                        } label: {
                            Label("Essentials", systemImage: "carrot")
                        }
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                VStack {
                    TextField("", text: $item)
                        .textFieldStyle(.roundedBorder)

                    Button {
                        let newItem = Item(title: item, isCompleted: false)
                        modelContext.insert(newItem)
                        try? modelContext.save()
                        item = ""
                    } label: {
                        Text("Save")
                    }
                }
                .padding()
            }
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
