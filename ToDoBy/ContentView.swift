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
//            Button("Reset UserDefaults") {
//                if let bundleID = Bundle.main.bundleIdentifier {
//                    UserDefaults.standard.removePersistentDomain(forName: bundleID)
//                }
//            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(store: Store())
    }
}
