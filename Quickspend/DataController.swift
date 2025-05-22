//
//  DataController.swift
//  Quickspend
//
//  Created by urja 💙 on 2025-04-13.
//

import Foundation
import CoreData

class DataController : ObservableObject {
    let container =  NSPersistentContainer(name: "Category")
    let containerExpense = NSPersistentContainer(name: "Expense")
    private let defaultCategories = [
        ("Food", "fork.knife"),
           ("Travel", "car.fill"),
           ("Shopping", "bag.fill"),
           ("Bills", "doc.text"),
           ("Health", "heart.fill")
    ]
    
    init(){
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
        if !UserDefaults.standard.bool(forKey: "hasLoadedDefaultCategories") {
            self.preloadDefaultCategories()
            UserDefaults.standard.set(true, forKey: "hasLoadedDefaultCategories")
        }
    }
    
    private func preloadDefaultCategories() {
        let context = container.viewContext
        for(name,iconName) in defaultCategories {
            let category = Category(context: context)
            category.id = UUID()
            category.name  = name
            category.iconName = iconName
            category.createdAt = Date()
        }
        do {
            try context.save()
            print("saved in default")
        } catch {
            print("❌ Failed to save default categories: \(error.localizedDescription)")
        }
    }
    
}
