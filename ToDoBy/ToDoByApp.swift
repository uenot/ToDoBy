//
//  ToDoByApp.swift
//  ToDoBy
//
//  Created by School on 3/10/21.
//

import SwiftUI

@main
struct ToDoByApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(store: Store())
        }
    }
}
