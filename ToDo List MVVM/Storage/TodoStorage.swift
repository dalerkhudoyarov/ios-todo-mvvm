//
//  TodoStorage.swift
//  ToDo List MVVM
//
//  Created by Daler Xudoyarov on 14.12.2025.
//

import Foundation

final class TodoStorage {
    private let key = "todo_items"
    func save(_ items: [TodoItem]) {
        if let data = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }
    func load() -> [TodoItem] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let items = try? JSONDecoder().decode([TodoItem].self, from: data) else {
            return []
        }
        return items
    }
    }
