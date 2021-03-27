//
//  ScheduleView.swift
//  ToDoBy
//
//  Created by School on 3/10/21.
//

import SwiftUI
import Foundation

struct ScheduleView: View {
    let schedule: Binding<Schedule>
    
    @State private var observedDate = Date() {
        didSet {
            dummyDay = Day([], date: observedDate)
            isDummy = false
        }
    }
    
    // TODO: makes it so that days are only stored if there have been no changes, ever, from the dummy
    // ideally, would compare to an empty day so that adding+deleting a task doesn't save the day
    // could change "clear" button to reset isDummy, but that only half solves the problem
    // i think it didn't work before because dates (down to time) were being compared
    // for both tasks + days
    // maybe custom equality methods would help?
    // todo later, going to leave for now
    
    // also: currently adds day to schedule twice
    // once if more than 1 task added, once on swipe to different day
    // doesn't affect function, just memory inefficient
    @State private var isDummy = false
    
    @State private var dummyDay = Day() {
        didSet {
            if isDummy {
                schedule.wrappedValue.add(oldValue)
            }
            isDummy = true
        }
    }
    
    func incrementDate(by amount: Int = 1) {
        observedDate = Calendar.current.date(byAdding: .day, value: amount, to: observedDate) ?? Date()
    }
    
    var dayIndex: Int? {
        let filteredDays = schedule.days.wrappedValue.indexed().filter { i, day in
            Calendar.current.isDate(day.date, equalTo: observedDate, toGranularity: .day)
        }
        if filteredDays.isEmpty {
            return nil
        }
        return filteredDays[0].index
    }
    
    var observedDay: Binding<Day> {
        if let i = dayIndex {
            return schedule.days[i]
        }
        // custom binding: triggers didSet of dummyDay when wrapped value mutates
        return Binding(
            get: { self.dummyDay },
            set: {
                self.dummyDay = $0
            })
    }
    
    var body: some View {
        VStack {
            DayView(day: observedDay)
                .gesture(DragGesture()
                            .onEnded { value in
                                if value.startLocation.x < value.location.x - 24 {
                                    incrementDate(by: -1)
                                }
                                if value.startLocation.x > value.location.x + 24 {
                                    incrementDate()
                                }
                            }
                )
//          Displays list of days in schedule
//            ForEach(schedule.wrappedValue.days) { day in
//                Text("\(day.dateText)")
//            }
        }
    }
}
/*
struct ScheduleView_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleView()
    }
}
*/
