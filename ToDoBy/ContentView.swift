//
//  ContentView.swift
//  ToDoBy
//
//  Created by School on 3/10/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject var store: Store
    
    var body: some View {
        VStack {
            ScheduleView(schedule: $store.schedule)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store(Schedule(days: [Day([Task("day 1")]),
                                           Day([Task("day 2")], date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)])))
    }
}
