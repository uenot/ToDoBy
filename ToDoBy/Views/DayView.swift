//
//  DayView.swift
//  ToDoBy
//
//  Created by School on 3/10/21.
//

import SwiftUI

struct DayView: View {
    let day: Binding<Day>
    
    var body: some View {
        VStack {
            NavigationView {
                List(day.tasks.wrappedValue.indexed(), id: \.1.id) { i, task in
                    NavigationLink(destination: TaskView(task: day.tasks[i])) {
                        Text(task.rowText)
                    }
                }
                .navigationTitle("Tasks for \(day.wrappedValue.dateText)")
            }
            Button("Add Task") {
                day.wrappedValue.add(Task("New Task"))
            }
            .padding()
            Button("Clear Task") {
                day.wrappedValue.clear()
            }
        }
    }
}
/*
struct DayView_Previews: PreviewProvider {
    static var previews: some View {
        DayView()
    }
}
*/
