//
//  ExpenseListView.swift
//  Quickspend
//
//  Created by urja 💙 on 2025-04-13.
//

import SwiftUI

struct ExpenseListView: View {
    
    
    @Environment(\.managedObjectContext) var context

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)],
        animation: .default
    ) var expenses: FetchedResults<Expense>
    var totalBalance : Double {
        expenses.reduce(0) { $0 + $1.amount }
    }
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                    Text("Total Spend :")
                        .font(.title)
                        .bold()
                    
                    Text("$\(totalBalance, specifier: "%.2f")")
                        .font(.title2)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            
                Text("Transcations : \(expenses.count)")
                    .padding(.top)
                    .font(.title2)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .leading)

                List {
                    ForEach(expenses, id : \.self) { expense in
                        ExpenseRowView(expense: expense)
                            .listRowSeparator(.hidden)
                            .listRowInsets(EdgeInsets())
                    }
                    .onDelete(perform: deleteExpense)
                }
                .listStyle(.plain)
                .listRowSpacing(8)
                .scrollContentBackground(.hidden)
                
                Spacer()
            }
            
            .frame(maxWidth : .infinity,alignment: .leading)
            .padding(.horizontal)
            .navigationTitle("All Transactions")
        }
        
    }
    func deleteExpense(at offSets : IndexSet) {
        for index in offSets {
            let expenseTodelete = expenses[index]
            context.delete(expenseTodelete)
        }
        
        do {
            try context.save()
            
        } catch {
            print("Failed to delete expense: \(error.localizedDescription)")

        }
    }
}

#Preview {
    ExpenseListView()
}
