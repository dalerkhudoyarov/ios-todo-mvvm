//
//  TodoListViewModel.swift
//  ToDo List MVVM
//
//  Created by Daler Xudoyarov on 14.12.2025.
//


import Foundation

    final class TodoListViewModel {
        
        private let storage = TodoStorage()
        
        private(set) var items: [TodoItem] = []
        
        var onUpdate: (() -> Void)?
        
        init() {
            load()
        }
        
        func load() {
            items = storage.load()
            onUpdate?()
        }
        
        func add(title: String) {
            let newItem = TodoItem(id: UUID(), title: title, isCompleted: false)
            items.append(newItem)
            save()
        }
        
        func toggle(at index: Int) {
            items[index].isCompleted.toggle()
            save()
        }
        
        func delete(at index: Int) {
            items.remove(at: index)
            save()
        }
        
        private func save() {
            storage.save(items)
            onUpdate?()
        }
    }
