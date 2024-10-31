//
//  CarDetail.swift
//  ListNavDemo
//
//  Created by Hannah Bauer on 10/22/24.
//

import SwiftUI

struct MealDetail: View {
    let selectedMeal: Meal
    
    var body: some View {
        Form {
            // More information on the meal for that specific meal - ingredients, recipe, etc
            Section(header: Text("Meal Details")) { // creates two different form sections for better layout
                
                Text("Name: \(selectedMeal.name)")
                    .font(.headline)
                    .padding(.vertical, 2)
                
                Text("Description: \(selectedMeal.description)")
                    .font(.body)
                    .padding(.vertical, 2)
            }
            // new section for meal information
            Section(header: Text("Meal Information")) {
                Text("Day: \(selectedMeal.day)") // day of the week
                    .font(.subheadline)
                    .padding(.vertical, 2)
                
                Text("Meal of the day: \(selectedMeal.type)") // meal of the day
                    .font(.subheadline)
                    .padding(.vertical, 2)
            }
        }
    }
}

#Preview {
    MealDetail(selectedMeal: Meal(id: UUID().uuidString, name: "Sample Meal", description: "A delicious sample meal", day: "Monday", type: "Breakfast"))
}
