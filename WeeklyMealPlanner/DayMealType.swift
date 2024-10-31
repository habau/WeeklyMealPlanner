//
//  DayMealType.swift
//  WeeklyMealPlanner
//
//  Created by Hannah Bauer on 10/29/24.
//

import Foundation

struct DayMealType: Hashable, Identifiable {
    let id = UUID() // Unique identifier for each instance
    let day: String
    let mealType: String
}
