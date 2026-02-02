//
//  DestinationListingView.swift
//  iTour
//
//  Created by Macpro M2    on 2026/02/02.
//

import SwiftUI
import SwiftData

struct DestinationListingView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Destination.priority, order: .reverse),
        SortDescriptor(\Destination.name) // 
    ]) var destinations: [Destination]
    
    var body: some View {
        List {
            ForEach(destinations) {destination in
                NavigationLink(value: destination) {
                    VStack (alignment: .leading) {
                        Text(destination.name)
                            .font(.headline)
                        Text(destination.date.formatted(date: .long, time: .shortened))
                            .font(.subheadline)
                    }
                }
            
            }
            .onDelete(perform: deleteDestinations)
        }
    }
    init(sort: SortDescriptor<Destination>, searchString: String, isFilter: Bool) {
        let now = Date.now
        _destinations = Query(filter: #Predicate {
            return (searchString.isEmpty || $0.name.localizedStandardContains(searchString)) && (!isFilter || $0.date > now)
            /*
            if searchString.isEmpty {
                return true
            } else {
                return $0.name.localizedStandardContains(searchString)
            }
            if isFilter {
                return true && $0.date >= Date.now
            }
             */
            //$0.date >= Date.now //$0.priority >= 2 Khi này các dữ liệu có độ ưu tiên thấp như 1 thì sẽ k bị xóa, mà chỉ là đang bị ẩn đi thôi
        }, sort: [sort], animation: .bouncy())
    }
    
    func deleteDestinations (_ indexSet: IndexSet) {
        for index in indexSet {
            let destination = destinations[index]
            modelContext.delete(destination)
        }
    }
    func filterDestinationsInFuture() {
        
    }
}

#Preview {
    DestinationListingView(sort: SortDescriptor(\Destination.name), searchString: "h", isFilter: true)
}
