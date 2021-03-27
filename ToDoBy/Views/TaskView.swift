//
//  TaskView.swift
//  ToDoBy
//
//  Created by School on 3/10/21.
//

import SwiftUI

struct TaskView: View {
    var task: Binding<Task>
    
    @State var manualUpdater = false
    
    func update() {
        manualUpdater.toggle()
    }
    
    var body: some View {
        VStack {
            TextField("Rename", text: task.name)
                .padding()
            HStack {
                Toggle("Specify Time", isOn: task.useTime.onChange { _ in
                    update()
                })
                if task.useTime.wrappedValue {
                    DatePicker("", selection: task.currentDate, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
            }
            Text("\(task.useTime.wrappedValue.description)")
            Toggle("Add Details", isOn: task.useDetails.onChange { _ in
                update()
            })
            if task.useDetails.wrappedValue {
                TextEditor(text: task.details)
                    .foregroundColor(.secondary)
            }
        }
    }
}

//struct TaskView_Previews: PreviewProvider {
//    static var previews: some View {
//        TaskView()
//    }
//}
