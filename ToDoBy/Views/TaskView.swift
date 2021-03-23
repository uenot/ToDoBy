//
//  TaskView.swift
//  ToDoBy
//
//  Created by School on 3/10/21.
//

import SwiftUI

struct TaskView: View {
    var task: Binding<Task>
    
    var body: some View {
        VStack {
            TextField("Rename", text: task.name)
                .padding()
            HStack {
                Toggle("Specify Time", isOn: task.useTime)
                if task.useTime.wrappedValue {
                    DatePicker("", selection: task.currentDate, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
            }
            Toggle("Add Details", isOn: task.useDetails)
            if task.useDetails.wrappedValue {
                TextField("Details", text: task.details)
            }
        }
    }
}
/*
struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
*/
