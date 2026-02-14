//
//  TodoItem.swift
//  ToDo List MVVM
//
//  Created by Daler Xudoyarov on 14.12.2025.
//

import Foundation

    struct TodoItem: Codable, Identifiable {
        let id: UUID
        var title: String
        var isCompleted: Bool
    }
