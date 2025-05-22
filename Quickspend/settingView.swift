//
//  settingView.swift
//  Quickspend
//
//  Created by urja 💙 on 2025-04-16.
//

import SwiftUI

struct settingView: View {
    
    @State private var budgetMonthly : String = ""
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            
            //HStack(){
                VStack(alignment: .leading){
                    
                    Text("Set Monthly Limit")
                        .font(.title)
                        .bold()
                    

                    TextField("Enter Amount", text: $budgetMonthly)
                        .padding()
                        .font(.title2) // Slightly smaller font for clarity
                        .keyboardType(.decimalPad)
                        .background(Color(.systemGray5))
                        .cornerRadius(12)
                        .padding(.bottom)
                    
                    Button("Save") {
                        saveData()
                    }
                    
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .bold()
                    .font(.title3)
                    
                       
                    
                    Spacer()
                    
                    
                }
                .padding()
                .navigationTitle("Quickspend")
           // }
           
        }
    }
    
    func saveData() {
        print("innsave")
        if let amount = Double(budgetMonthly) {
            print(amount)
            let defaults = UserDefaults.standard
            defaults.set(amount, forKey: "MonthlyBudget")
            dismiss()
            
        }
    }
}

#Preview {
    settingView()
}
