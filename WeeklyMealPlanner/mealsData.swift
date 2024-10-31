//
//  mealsData.swift
//  WeeklyMealPlanner
//
//  Created by Hannah Bauer on 10/17/24.
//

import Foundation
import SwiftUI

var mealsData: [Meal] = loadJson("MealsData") // Load data from MealsData.json into an array of Meal objects.

func loadJson<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    // Attempt to locate the file with the specified JSON extension
    guard let file = Bundle.main.url(forResource: filename, withExtension: "json") else {
        fatalError("\(filename).json not found.")
    }
    
    do {
        // Load data from the file
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename).json: \(error)")
    }
    
    do {
        // Decode JSON data into the specified type
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename).json: \(error)")
    }
}
 
