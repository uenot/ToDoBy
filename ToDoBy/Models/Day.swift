//
//  Day.swift
//  ToDoBy
//
//  Created by School on 3/10/21.
//

import Foundation

struct Day: Codable, Identifiable, Equatable, Hashable {
    
    var id: UUID = UUID()
    var date: Date = Date()
    static var formatter = DateFormatter()
    var dateText: String {
        Self.formatter.dateStyle = .medium
        return Self.formatter.string(from: date)
    }
    
    var tasks: [Task] = []
    
    mutating func clear() {
        tasks = []
    }
    
    mutating func add(_ item: Task) {
        tasks.append(item)
    }
    
    init() {}
    
    init(_ tasks: [Task]) {
        self.tasks = tasks
    }
    
    init(_ items: [Task], date: Date) {
        self.tasks = items
        self.date = date
    }
}
