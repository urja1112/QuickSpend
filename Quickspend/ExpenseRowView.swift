//
//  ExpenseRowView.swift
//  Quickspend
//
//  Created by urja 💙 on 2025-04-12.
//

import SwiftUI

struct ExpenseRowView: View {

    let expense : Expense
    var body: some View {
        HStack {
            Image(systemName: expense.category?.iconName ?? "questionmark.folder.fill")
                .font(.title3)
                //.frame(width: 24, height: 25)
                .padding()
                .background(Color.green.opacity(0.70))
                .cornerRadius(16)
                .foregroundStyle(.white)
           
            VStack(alignment: .leading, spacing: 4) {
                
                
              
                Text(expense.note!)
                    .font(.headline)
                HStack(spacing: 12) {
                    Text(expense.category?.name ?? "Grocery")
                        .font(.subheadline)
                    Text(expense.date?.formatted(date: .long, time: .omitted) ?? "\(Date.now)")
                        .font(.headline)
                  
                }
               
            }
            Spacer()
            Text(String(format: "$%.2f", expense.amount))
                .bold()
           
        }
        .padding()
        .background(Color(.secondarySystemBackground).opacity(0.60))
        .cornerRadius(20)
    }
}

#Preview {
    
    
}
