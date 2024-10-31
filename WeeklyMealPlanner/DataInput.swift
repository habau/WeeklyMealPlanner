//
//  DataInput.swift
//  WeeklyMealPlanner
//
//  Created by Hannah Bauer on 10/29/24.
//

import SwiftUI

struct DataInput: View {
    var title: String
    @Binding var userInput: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.leading)
            
            TextField("Enter \(title)", text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.bottom, 10)
        }
        .padding()
    }
}
