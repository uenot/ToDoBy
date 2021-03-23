//
//  Schedule.swift
//  ToDoBy
//
//  Created by School on 3/10/21.
//

import Foundation

struct Schedule {
    var days: [Day] = []
    
    mutating func add(_ day: Day) {
        days.append(day)
    }
}

extension Schedule: Codable {
    enum CodingKeys: CodingKey {
        case days
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(days, forKey: .days)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        days = try container.decode([Day].self, forKey: .days)
    }
}

extension Schedule: RawRepresentable {
    init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode(Self.self, from: data)
        else { return nil }
        self = result
    }
    
    var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else { return "[]" }
        return result
    }
}
