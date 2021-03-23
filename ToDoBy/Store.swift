//
//  Store.swift
//  ToDoBy
//
//  Created by School on 3/10/21.
//

import Foundation
import SwiftUI

final class Store: ObservableObject {
    @AppStorage("tdbStore") var scheduleStorage: Schedule = Schedule()
    
    var schedule: Schedule = {
        guard let rawSchedule = UserDefaults.standard.string(forKey: "tdbStore") else { return Schedule() }
            return Schedule(rawValue: rawSchedule) ?? Schedule()
    }() {
        willSet {
            objectWillChange.send()
        }
        didSet {
            scheduleStorage = schedule
        }
    }
    
    init(_ schedule: Schedule) {
        UserDefaults.standard.set(schedule, forKey: "tdbStore")
    }
    
    init() {}
}
