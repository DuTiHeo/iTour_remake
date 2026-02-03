//
//  Destination.swift
//  iTour
//
//  Created by Macpro M2    on 2026/01/31.
//

import Foundation
import SwiftData

@Model
class Destination {
    var name: String
    var details: String
    var date: Date
    var priority: Int
    @Relationship(deleteRule: .cascade) var sights = [Sight]()
    
    init(name:String = "", details:String = "", date:Date = .now, priority: Int = 2, sights: [Sight] = []) {
        self.name = name
        self.details = details
        self.date = date
        self.priority = priority
        self.sights = sights
    }
}
