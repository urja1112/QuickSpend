//
//  ContentView.swift
//  Quickspend
//
//  Created by urja 💙 on 2025-04-12.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    @State private var showAddExpense = false
   
    @State private var isShowingSetting = false
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Expense.date, ascending: false)],
        animation: .default
    ) var expenses: FetchedResults<Expense>
    var totalBalance : Double {
        expenses.reduce(0) { $0 + $1.amount }
    }

    @AppStorage("MonthlyBudget") private var budget: Double = 0.0

    var progress: Double {
        budget > 0 ? totalBalance / budget : 0
    }
    
    var body: some View {
        ZStack {
            NavigationStack {
                
                VStack(alignment: .leading, spacing: 16) {
                    
                    Text("Hello, Urja")
                        .font(.title)
                        .bold()
                    HStack(spacing: 20) {
                        
                        CircularProgressView(progress: progress)
                            .frame(width: 100, height: 100)
                            .padding()
                            
                        
                       
                        
                        VStack {
                            Text("Total Balance")
                                .font(.headline)
                            Text("$\(String(format: "%.2f", totalBalance))")
                                .font(.title)
                                .bold()
                        }
                        .padding()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green.opacity(0.1))
                    .cornerRadius(12)
                    
                    HStack {
                        Text("Recent Transcations")
                            .font(.headline)
                        Spacer()
                        NavigationLink(destination: ExpenseListView()) {
                            Text("SEE ALL")
                                .font(.subheadline)
                                .foregroundStyle(.blue)
                                
                        }
                        .padding([.leading,.trailing])
                    }
                  
                    
                    List {
                        ForEach(expenses.prefix(3), id : \.self) { expense in
                            ExpenseRowView(expense: expense)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                        }
                    }
                    .listStyle(.plain)
                    .listRowSpacing(8)
                    .scrollContentBackground(.hidden)
                    
                  
                    
                    //  .frame(maxHeight: 300)
                    
                    
                }
                .padding()
                .navigationTitle("Quickspend")
                .toolbar {
                    ToolbarItem(placement: .automatic) {
                        Button(action: {
                            isShowingSetting = true
                        }) {
                            Image(systemName: "gearshape.fill")
                                .font(.title2)
                        }
                    }
                }
                
                
            }
            
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    FloatingAddButton {
                        showAddExpense.toggle()
                    }
                }
            }
            
        }
        .sheet(isPresented: $showAddExpense) {
            AddExpenseView()
        }
        .sheet(isPresented: $isShowingSetting) {
            settingView()
        }
        
    }
    
    func getData() {
        
    }
}

#Preview {
    ContentView()
}
