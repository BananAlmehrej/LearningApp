//
//  WeeklyTaskViewModel.swift
//  LearningApp
//
//  Created by Banan Almehrej on 19/04/1446 AH.
//
import Foundation
import SwiftUI

class WeeklyTaskViewModel: ObservableObject {
    @Published var currentWeek = Week(days: [], selectedDay: Date())
    @Published var streak: Streak
    @Published var learnedDays: Set<Date> = [] // Days marked as learned
    @Published var frozenDays: Set<Date> = [] // Days marked as frozen
    @Published var selectedMonth = Calendar.current.component(.month, from: Date()) - 1
    @Published var selectedYear = Calendar.current.component(.year, from: Date())
    
    init() {
        let today = Date()
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: today))!
        
        let daysOfWeek = (0..<7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: startOfWeek)
        }
        
        self.currentWeek = Week(days: daysOfWeek, selectedDay: today)
        self.streak = Streak(dayStreak: 0, frozenDays: 0, maxFreezes: 6)
    }
    
    func updateWeek(for date: Date) {
        let calendar = Calendar.current
        // احصل على بداية الأسبوع بناءً على التاريخ المعطى
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
        // أنشئ تواريخ الأسبوع بناءً على بداية الأسبوع
        let daysOfWeek = (0..<7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: startOfWeek)
        }
        // حدّث `currentWeek` ليشمل أيام الأسبوع الجديدة
        self.currentWeek = Week(days: daysOfWeek, selectedDay: date)
    }
    
    func logTodayAsLearned() {
        let today = Calendar.current.startOfDay(for: Date())
        learnedDays.insert(today)
        streak.dayStreak += 1
        objectWillChange.send() // تأكد من أن التحديث يظهر
        updateWeek(for: currentWeek.selectedDay) // إعادة بناء `currentWeek` للتحديث
    }
    
    func freezeToday() {
        let today = Calendar.current.startOfDay(for: Date())
        if frozenDays.count < streak.maxFreezes && !frozenDays.contains(today) {
            frozenDays.insert(today)
            streak.frozenDays += 1
            objectWillChange.send() // تأكد من أن التحديث يظهر
            updateWeek(for: currentWeek.selectedDay) // إعادة بناء `currentWeek` للتحديث
        }
    }
    
    func goToPreviousWeek() {
        if let newSelectedDay = Calendar.current.date(byAdding: .day, value: -7, to: currentWeek.selectedDay) {
            updateCalendar(for: newSelectedDay)
        }
    }
    
    func goToNextWeek() {
        if let newSelectedDay = Calendar.current.date(byAdding: .day, value: 7, to: currentWeek.selectedDay) {
            updateCalendar(for: newSelectedDay)
        }
    }
    
    func updateCalendar(for date: Date) {
        let calendar = Calendar.current
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
        
        let daysOfWeek = (0..<7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: startOfWeek)
        }
        
        self.currentWeek = Week(days: daysOfWeek, selectedDay: date)
    }
    
    func updateCalendarForMonth() {
        var dateComponents = DateComponents()
        dateComponents.year = selectedYear
        dateComponents.month = selectedMonth + 1
        let date = Calendar.current.date(from: dateComponents) ?? Date()

        let firstDayOfWeek = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: date)) ?? Date()
        let days = generateWeek(from: firstDayOfWeek)
        
        currentWeek = Week(days: days, selectedDay: firstDayOfWeek)
    }

    func generateWeek(from startDate: Date) -> [Date] {
        let calendar = Calendar.current
        var days: [Date] = []
        for i in 0..<7 {
            if let day = calendar.date(byAdding: .day, value: i, to: startDate) {
                days.append(day)
            }
        }
        return days
    }

    func updateCalendarForYear() {
        updateCalendarForMonth()
    }
}
