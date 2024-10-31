//
//  MealListView.swift
//  WeeklyMealPlanner
//
//  Created by Hannah Bauer on 10/29/24.
//

import SwiftUI

struct MealListView: View {
    @EnvironmentObject var mealStore: MealStore
    var day: String // day of the week
    var mealType: String // meal of the day
    @State private var isPresentingAddMeal = false
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            // Custom Header Title layout
            Text("\(day) - \(mealType)")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.top)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            
            List {
                Section(header: EmptyView()) { // no header - aesthetic purposes
                    ForEach(mealsForDayAndType(), id: \.self) { meal in
                        NavigationLink(destination: MealDetail(selectedMeal: meal)) {
                            Text(meal.name)
                                .font(.headline)
                        }
                    }
                    .onDelete(perform: deleteItems)
                    .onMove(perform: moveItems)
                }
            }
            
            // Centered "Add Meal" Button
            Button(action: {
                isPresentingAddMeal = true
            }) {
                Text("Add Meal")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
                    .padding()
            }
            // add a new meal - path to storing the new meal data inputs
            .sheet(isPresented: $isPresentingAddMeal) {
                AddNewMeal(path: $path, day: day, type: mealType)
                    .environmentObject(mealStore)
            }
        }
        .onAppear {
            print("Current meals for \(day) - \(mealType): \(mealsForDayAndType())") // layout
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }

    // Filter meals based on day and meal type
    func mealsForDayAndType() -> [Meal] {
        return mealStore.meals.filter { $0.day == day && $0.type == mealType }
    }

    // Delete items from mealStore based on filtered list
    func deleteItems(at offsets: IndexSet) {
        let mealsToDelete = mealsForDayAndType()
        offsets.map { mealsToDelete[$0] }.forEach { meal in
            if let index = mealStore.meals.firstIndex(of: meal) {
                mealStore.meals.remove(at: index)
            }
        }
    }

    // Move items within the filtered list and update the main meal list
    func moveItems(from source: IndexSet, to destination: Int) {
        let mealsToMove = mealsForDayAndType()
        
        guard destination < mealsToMove.count else { // test case if it doesnt work
            print("Error: Destination index \(destination) out of range for mealsToMove count \(mealsToMove.count).")
            return
        }
        
        let sourceIndices = source.compactMap { index in
            mealStore.meals.firstIndex(of: mealsToMove[index])
        }
        
        if let destinationMeal = mealsToMove[safe: destination],
           let destinationIndex = mealStore.meals.firstIndex(of: destinationMeal) {
            
            print("Moving items from \(sourceIndices) to \(destinationIndex) in mealStore.meals")

            mealStore.meals.move(fromOffsets: IndexSet(sourceIndices), toOffset: destinationIndex)
        } else {
            print("Error: Unable to map destination or source indices.")
        }
    }
}
// for safe property - updated from previous error
extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
