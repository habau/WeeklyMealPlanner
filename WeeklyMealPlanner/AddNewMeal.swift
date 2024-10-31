//
//  AddNewMeal.swift
//  ListNavDemo
//
//  Created by Hannah Bauer on 10/22/24.
//
import Foundation
import SwiftUI
//import PhotosUI

// Add a new meal
struct AddNewMeal: View {
    @EnvironmentObject var mealStore: MealStore
    @Binding var path: NavigationPath
    var day: String
    var type: String
    
    @State private var name: String = ""
    @State private var description: String = "" // State variable for description

    // this was for uploading image but I will add this feature later
//    @State private var selectedImageItem: PhotosPickerItem? = nil
//    @State private var selectedImageData: Data? = nil
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            // create layout similar to Apple Contacts
            VStack {
                Image(systemName: "fork.knife.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 160, height: 160)
                    .padding(.top, -60)
                
                // create the form layout for entering name and description
                Form {
                    TextField("Enter Name", text: $name)
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(8)
                        .cornerRadius(8)
                    
                    TextField("Enter Description", text: $description) // Bind to description state
                        .textFieldStyle(PlainTextFieldStyle())
                        .padding(8)
                        .cornerRadius(8)
                 
            // FOR IMAGE PICKER - ADD LATER
//                    if let imageData = selectedImageData, let uiImage = UIImage(data: imageData) {
//                        Image(uiImage: uiImage)
//                            .resizable()
//                            .scaledToFit()
//                            .frame(height: 150)
//                    }
                    
//                    PhotosPicker(selection: $selectedImageItem, matching: .images, photoLibrary: .shared()) {
//                        Text("Upload Meal Image")
//                            .font(.headline)
//                            .foregroundColor(.blue)
//                    }
//                    .onChange(of: selectedImageItem) { newItem in
//                        Task {
//                            if let data = try? await newItem?.loadTransferable(type: Data.self) {
//                                selectedImageData = data
//                            }
//                        }
//                    }
                }
                .padding(.horizontal, 20)
                
                // add new meal button at the bottom
                Button(action: addNewMeal) {
                    Text("Add Meal")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(4)
                        .shadow(radius: 5)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Back") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Add New Meal")
                        .font(.title2)
                        .fontWeight(.bold)
                }
            }
        }
    }
    
    // for reading the json information
    func addNewMeal() {
        let newMeal = Meal(
            id: UUID().uuidString,
            name: name,
            description: description, // Include description
            day: day,
            type: type
        )
        mealStore.meals.append(newMeal)
        dismiss()
    }
}
