//
//  AddExpenseView.swift
//  Quickspend
//
//  Created by urja 💙 on 2025-04-13.
//

import SwiftUI
import CoreData

struct AddExpenseView: View {
    @State private var expenseAmount = 00.00
    @Environment(\.managedObjectContext) var context
    @State private var selectedCategory : Category?
    @State private var showAddCategorySheet = false
    @State private var selectedDate : Date = .now
    @State private var Description : String = ""
    @Environment(\.dismiss) var dismiss
    
    
    @FetchRequest(entity: Category.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Category.createdAt, ascending: true)]) var categories: FetchedResults<Category>
    var body: some View {
        NavigationStack {
            VStack(spacing : 20) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(alignment: .firstTextBaseline, spacing: 2) {
                        Text("$")
                            .font(.title)
                            .bold()

                        TextField("0.00", value: $expenseAmount, format: .number)
                            .font(.title)
                            .bold()
                            .keyboardType(.decimalPad)
                    }
                    .frame(height : 60)
                    .padding()
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(12)
                }
                .padding(.horizontal)
            
                
              //  Spacer()
                VStack(alignment: .leading, spacing: 8){
                    Text("Category")
                        .font(.title)
                        .bold()
                        .padding(.leading)
                    
                    ScrollView(.horizontal,showsIndicators: false) {
                        HStack(spacing: 16) {
                            ForEach(categories, id : \.self) { category in
                                
                                VStack (spacing : 4) {
                                    Image(systemName: category.iconName ?? "questionmark")
                                        .font(.title2)
                                         .frame(width: 24, height: 24)
                                        .padding()
                                        .background(
                                            Circle()
                                                .fill(selectedCategory == category ? Color.green : Color.gray)
                                        )
                                        .frame(width: 60, height: 60)
                                        .foregroundStyle(.white)
                                    
                                    Text(category.name ?? "Unknown")
                                        .font(.caption)
                                        .foregroundStyle(.black)
                                }
                                .frame(width : 70)
                                .onTapGesture {
                                    selectedCategory = category
                                }
                            }
                            
                           
                                Button {
                                    showAddCategorySheet.toggle()
                                } label: {
                                
                                    VStack(spacing : 4) {
                                        Image(systemName: "plus.app.fill")
                                            .font(.title2)
                                            .frame(width: 24, height: 24)
                                            .padding()
                                            .background(
                                                Circle()
                                                    .fill(showAddCategorySheet ? Color.green : Color.green.opacity(0.30))
                                            )
                                            .frame(width: 60, height: 60)
                                            .foregroundStyle(.white)
                                        Text("Add")
                                            .font(.caption)
                                            .foregroundStyle(.black)
                                    }
                                    .frame(width: 70)
                            }
                        
                                
                                }
                            .padding()
                        }
                   // Spacer()
                    
                    HStack(spacing : 16) {
                        Image(systemName: "calendar")
                            .font(.title)
                        DatePicker("Select Date", selection: $selectedDate, in: ...Date.now,displayedComponents: .date)
                            .labelsHidden()
                        
                        
                        
                    }
                    .padding(.horizontal,25)
                    .padding(.top)
                   
                      
                    }
               // Spacer()
                
                TextField("Description", text: $Description)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.top)
                
                
                Button("Save") {
                    saveData()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(12)
                .padding(.horizontal)
                .padding(.top,30)
                .bold()
                .font(.title3)
               
                Spacer()
                    
                }
            .navigationTitle("ADD EXPENSE")
            .padding(.top)
            .sheet(isPresented: $showAddCategorySheet) {
                AddCategory()
                    .environment(\.managedObjectContext, context) // 👈 Pass the context explicitly

            }

                
                
            }
            
            
        
    }
    
    func saveData() {
        print("in save data \(expenseAmount) \(selectedCategory?.iconName) \(selectedDate) ")
        
        let newExpense = Expense(context : context)
        newExpense.id = UUID()
        newExpense.note = Description
        newExpense.amount = expenseAmount
        newExpense.date = selectedDate
        newExpense.category = selectedCategory
        
        do {
            try context.save()
            dismiss()
        } catch {
            print("error with this \(error.localizedDescription)")
        }
    
        
    }
}

#Preview {
    AddExpenseView()
}


//ScrollView(.horizontal,showsIndicators: false) {
//    HStack(spacing: 16) {
//        ForEach(categories,id: \.self) { category in
//            VStack(spacing : 16){
//                Image(systemName: category.iconName ?? "questionmark")
//                    .font(.title2)
//                    .foregroundStyle(.white)
//                    .padding()
//                    .background( Circle()
//                        .fill( selectedCategory == category ? Color.green : Color.green.opacity(0.3)))
//                
//                Text(category.name ?? "ABC")
//                    .font(.caption)
//                    .foregroundStyle(.primary)
//                
//                
//            }                        .padding(.vertical,8)
//                .padding(.horizontal,12)
//                .background(Color(.systemGray6))
//                .cornerRadius(12)
//                .overlay (
//                    RoundedRectangle(cornerRadius: 12)
//                        .stroke(selectedCategory == category ? Color.green : Color.clear, lineWidth: 2)
//                )
//                .onTapGesture {
//                    selectedCategory = category
//                }
//        }
//        Button {
//            showAddCategorySheet = true
//        } label: {
//            VStack(spacing: 12) {
//                Image(systemName: "plus")
//                    .font(.title)
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(
//                        Circle()
//                            .fill(Color.green.opacity(0.6))
//                    )
//
//                Text("Add")
//                    .font(.caption)
//                    .foregroundColor(.primary)
//            }
//            .padding(.vertical, 8)
//            .padding(.horizontal, 12)
//            .background(Color(.systemGray6))
//            .cornerRadius(12)
//           
//            
//        }
//    }
//    .padding()
//    
//    
//}
