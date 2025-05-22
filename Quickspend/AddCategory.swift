//
//  AddCategory.swift
//  Quickspend
//
//  Created by urja 💙 on 2025-04-14.
//

import SwiftUI
import CoreData

struct AddCategory: View {
    @State private var categoryName : String = ""
    @State private var sfSymbols : [String] = []
    @State private var selectedCategory = ""
    @Environment(\.managedObjectContext) var context
    @State private var categoryExist = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                VStack(alignment: .leading,spacing: 16){
                    Text("Category Name")
                        .font(.title)
                        .bold()
                    
                    TextField("Enter Name", text: $categoryName)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                       
                }
                .padding(.horizontal,16)
               // Spacer()
                
                VStack(alignment: .leading, spacing: 16) {
                    Text("Select Icon")
                        .font(.title)
                        .bold()
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack {
                            ForEach(sfSymbols, id : \.self) { symbols in
                                Image(systemName: symbols)
                                    .font(.title2)
                                    .frame(width: 24, height: 24)
                                    .padding()
                                    .background(
                                        Circle()
                                            .fill(selectedCategory == symbols ? Color.green : Color.gray)
                                    )
                                    .frame(width: 60, height: 60)
                                    .foregroundStyle(.white)
                                    .onTapGesture {
                                        selectedCategory = symbols
                                    }
                            }
                            
                            
                        }
                       
                    }
                    
                }
                .padding(.horizontal,16)
                .padding(.top)
                .padding(.bottom)
               // Spacer()
                
                Button("Save") {
                    saveCategory()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
                .bold()
                .font(.title3)
               
           
                Spacer()
                  

                }
            
            .onAppear() {
                loadSymbols()
            }
            .padding(.top)
            .navigationTitle("Add Category")
            .alert("Category already exists", isPresented: $categoryExist) {
                Button("Okay") {
                    dismiss()
                }
            }
        }
    }
    
    func loadSymbols() {
        if let url = Bundle.main.url(forResource: "symbols", withExtension: "json"), let data = try? Data(contentsOf: url) , let decoded = try? JSONDecoder().decode([String].self, from: data) {
            sfSymbols = decoded
        }
    }
    func saveCategory() {
       
        print(selectedCategory)
        print(categoryName)
        

        
        let trimmedName = categoryName.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Category")
        fetchRequest.predicate = NSPredicate(format: "name == [c] %@", trimmedName)
        fetchRequest.fetchLimit = 1

        
        do {
            
            let existing = try context.fetch(fetchRequest)
            if !existing.isEmpty {
                categoryExist.toggle()
                print("Category already exists.")
            
                return
            }
            let newCateogry = Category(context: context)
            newCateogry.id = UUID()
            newCateogry.name = categoryName
            newCateogry.iconName = selectedCategory
            try context.save()
            dismiss()
        } catch {
            print("Failed to save category: \(error.localizedDescription)")
        }
    }
}

#Preview {
    AddCategory()
}
