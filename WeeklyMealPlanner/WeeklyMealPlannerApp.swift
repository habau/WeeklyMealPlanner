//
//  ListNavDemoApp.swift
//  ListNavDemo
//
//  Created by Hannah Bauer on 10/17/24.
//
import SwiftUI

@main
struct WeeklyMealPlannerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MealStore(meals: mealsData)) // Initialize MealStore with mealsData
        }
    }
}
