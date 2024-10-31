//
//  MealStore.swift
//  WeeklyMealPlanner
//
//  Created by Hannah Bauer on 10/17/24.
//

import Foundation
import SwiftUI

class MealStore: ObservableObject {
    @Published var meals: [Meal]

    init(meals: [Meal] = []) {
        self.meals = meals
    }
}
