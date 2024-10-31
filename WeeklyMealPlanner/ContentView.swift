//
//  ContentView.swift
//  WeeklyMealPlanner
//
//  Created by Hannah Bauer on 10/17/24.
//
import SwiftUI

struct ContentView: View {
    @StateObject var mealStore = MealStore(meals: mealsData) // access the meals data json
    @State private var stackPath = NavigationPath()
    @State private var isPresentingAddMeal = false // tracks if adding meal
    @State private var selectedDay: String = "" // stores the day of the week
    @State private var selectedMealType: String = "" // stores the meal of the day
    
    // Days and Meal Types
    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    let mealTypes = ["Breakfast 🍳", "Lunch 🍗", "Dinner 🍝"]

    var body: some View {
        NavigationStack(path: $stackPath) {
            List {
                // Loop through days of the week
                ForEach(daysOfWeek, id: \.self) { day in
                    Section(header: Text(day)
                                .font(.title)
                                .bold()
                                .foregroundColor(.gray)) {
                        // Loop through meal types
                        ForEach(mealTypes, id: \.self) { mealType in
                            let dayMealType = DayMealType(day: day, mealType: mealType)
                            
                            // NavigationLink to MealListView to add meal to meal list view
                            NavigationLink(value: dayMealType) {
                                Text(mealType).font(.title2)
                            }
                            .contextMenu {
                                Button("Add Meal") {
                                    selectedDay = day
                                    selectedMealType = mealType
                                    isPresentingAddMeal = true
                                }
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: DayMealType.self) { dayMealType in
                // Navigate to MealListView with day and mealType parameters
                MealListView(day: dayMealType.day, mealType: dayMealType.mealType, path: $stackPath)
                    .environmentObject(mealStore)
            }
            // Header of the page
            .navigationTitle("Weekly Meal Planner")
            .sheet(isPresented: $isPresentingAddMeal) {
                // Present AddNewMeal modal
                AddNewMeal(path: $stackPath, day: selectedDay, type: selectedMealType)
                    .environmentObject(mealStore)
            }
        }
        .environmentObject(mealStore) // Inject mealStore into the environment for child views
    }
}
