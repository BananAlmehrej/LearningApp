//
//  DateDef.swift
//  LearningApp
//
//  Created by Banan Almehrej on 19/04/1446 AH.
//

import Foundation

struct Week: Identifiable {
    let id = UUID()
    var days: [Date]
    var selectedDay: Date
}

struct Streak {
    var dayStreak: Int
    var frozenDays: Int
    var maxFreezes: Int
}

