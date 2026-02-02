//
//  EditDestinationView.swift
//  iTour
//
//  Created by Macpro M2    on 2026/01/31.
//

import SwiftUI
import SwiftData
struct EditDestinationView: View {
    @Environment(\.modelContext) var modelContext
    
    @Bindable var destination: Destination
    @State private var newSightName = ""
    @Query(sort: [SortDescriptor(\Sight.name)]) var sights: [Sight]
    var body: some View {
        Form {
            TextField("Name", text: $destination.name)
            TextField("Details", text: $destination.details, axis: .vertical)
            DatePicker("Date", selection: $destination.date)
            
            Section("Priority") {
                Picker("Priority", selection: $destination.priority) {
                    Text("Meh").tag(1)
                    Text("May").tag(2)
                    Text("Must").tag(3)
                }
                .pickerStyle(.automatic)
            }
            Section("Sight") {
                ForEach(sights) { sight in
                    Text(sight.name)
                }
                .onDelete(perform: deleteSights)
                HStack {
                    TextField("Add a new sight in \(destination.name)", text: $newSightName)
                    Button("", systemImage: "plus", action: addSight)
                }
            }
        }
        .navigationTitle("Edit Destination")
        .navigationBarTitleDisplayMode( .inline )
    }
    func addSight() {
        guard newSightName.isEmpty == false else { return }
        let sight = Sight(name: newSightName)
        destination.sights.append(sight)
        newSightName = ""
    }
    func deleteSights(_ indexSet: IndexSet) {
        for index in indexSet {
            let sight = sights[index]
            modelContext.delete(sight)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Destination.self , configurations: config)
        let example = Destination(name: "Emxple Destination", details: "Vi do toi day va se tu dong cap nhat ma nguoi dung thay doi")
        return EditDestinationView(destination: example)
            .modelContainer(container)

    } catch {
        fatalError("Failed to create a ModelContainer: \(error)")
    }
}
