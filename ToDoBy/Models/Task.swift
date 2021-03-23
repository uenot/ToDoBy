//
//  Task.swift
//  ToDoBy
//
//  Created by School on 3/10/21.
//

import Foundation

struct Task: Codable, Identifiable, Equatable, Hashable {
    var id = UUID()
    var name: String
    var details: String = ""
    var useDetails: Bool = false
    var currentDate = Date()
    var useTime: Bool = false
    static var formatter = DateFormatter()
    
    var timeText: String {
        Self.formatter.timeStyle = .short
        return Self.formatter.string(from: currentDate)
    }
    
    var rowText: String {
        name + (useTime ? " by \(timeText)" : "")
    }

    init(_ name: String) {
        self.name = name
    }
}
