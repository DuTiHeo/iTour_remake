//
//  ContentView.swift
//  iTour
//
//  Created by Macpro M2    on 2026/01/31.
//
import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var path = [Destination]()
    @State private var sortOrder = SortDescriptor(\Destination.name)
    @State private var searchText: String = ""
    @State private var isFilterInFuture: Bool = false
    var body: some View {
        ZStack {
            NavigationStack(path: $path) {
                DestinationListingView(sort: sortOrder, searchString: searchText, isFilter: isFilterInFuture)
                    .navigationTitle("iTour")
                    .navigationDestination(for: Destination.self) { destination in
                        EditDestinationView(destination: destination)
                    }
                    //toolbar k đẩy sang đc DestinationListingView.swìt vì nó là 1 phương thức trong NavigationStack, kphai của List
                    
                    .searchable(text: $searchText, prompt: Text("Search Destination"))
                    .toolbar {
                        Button ("Add Destination", systemImage: "plus", action: addDestination)
                        Menu("Sort", systemImage: "arrow.up.arrow.down") {
                            Picker("Sort", selection: $sortOrder) {
                                Text("Name")
                                    .tag(SortDescriptor(\Destination.name))
                                Text("Priority")
                                    .tag(SortDescriptor(\Destination.priority, order: .reverse))
                                Text("Date")
                                    .tag(SortDescriptor(\Destination.date))
                            }
                            .pickerStyle(.inline)
                        }
                        
                        Menu("Filter", systemImage: "line.3.horizontal.decrease.circle") {
                            Picker("Filter", selection: $isFilterInFuture) {
                                Text("Filter in future")
                                    .tag(true)
                                Text("Show all")
                                    .tag(false)
                            }
                        }
                         
                        
                    }
                
            }
            
        }
    }
    
    func addDestination() {
        
        let destination = Destination()
        modelContext.insert(destination)
        path = [destination]
         
        // Random name samples
        /*
        let nameSamples = [
            "Paris Getaway", "Tokyo Adventure", "Alpine Retreat",
            "Beach Escape", "Desert Trek", "City Lights",
            "Northern Lights", "Island Hopping", "Cultural Tour",
            "Mountain Summit"
        ]
        // Random details samples
        let detailSamples = [
            "Khám phá ẩm thực địa phương và bảo tàng nổi tiếng.",
            "Lịch trình linh hoạt, ưu tiên trải nghiệm văn hoá.",
            "Chụp ảnh hoàng hôn và trekking nhẹ.",
            "Thử các hoạt động ngoài trời và thư giãn.",
            "Tham quan các địa danh lịch sử và nghệ thuật.",
            "Tận hưởng cảnh quan thiên nhiên hùng vĩ.",
            "Khám phá khu chợ đêm và street food.",
            "Thư giãn tại resort và spa địa phương.",
            "Tham gia tour hướng dẫn bản địa.",
            "Tự lái xe khám phá ngoại ô."
        ]
        
        // Random name & details
        let randomName = nameSamples.randomElement() ?? "New Destination"
        let randomDetails = detailSamples.randomElement() ?? "Chuyến đi thú vị."
        
        // Random date: within ±30 days from now
        let dayRange = -30...30
        let randomDayOffset = Int.random(in: dayRange)
        let randomHourOffset = Int.random(in: -12...12)
        let randomDate = Calendar.current.date(byAdding: .day, value: randomDayOffset, to: .now)
            .flatMap { Calendar.current.date(byAdding: .hour, value: randomHourOffset, to: $0) } ?? .now
        
        // Random priority: 1 (Meh), 2 (May), 3 (Must)
        let randomPriority = Int.random(in: 1...3)
        
        let destination = Destination(
            name: randomName,
            details: randomDetails,
            date: randomDate,
            priority: randomPriority
        )
        modelContext.insert(destination)
        path = [destination]
         */
    }
}

#Preview {
    ContentView()
}
