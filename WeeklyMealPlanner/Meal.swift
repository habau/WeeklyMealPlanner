//
//  Meal.swift
//  WeeklyMealPlanner
//
//  Created by Hannah Bauer on 10/17/24.
//
import Foundation
import SwiftUI

struct Meal: Identifiable, Codable, Hashable {
    let id: String // meal number for json
    var name: String // name of meal
    var description: String // description of meal
    var day: String // day of week
    var type: String // meal of day
}
