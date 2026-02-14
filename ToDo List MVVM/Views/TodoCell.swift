//
//  TodoCell.swift
//  ToDo List MVVM
//
//  Created by Daler Xudoyarov on 14.12.2025.
//

import UIKit
    final class TodoCell: UITableViewCell {
        
        static let identifier = "TodoCell"
        
        private let titleLabel = UILabel()
        
        private let toggle = UISwitch()
        
        var onToggle: (() -> Void)?
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            setup()
        }
        required init?(coder: NSCoder) { fatalError() }
        private func setup() {
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            toggle.translatesAutoresizingMaskIntoConstraints = false
            toggle.addTarget(self, action: #selector(didToggle), for: .valueChanged)
            contentView.addSubview(titleLabel)
            contentView.addSubview(toggle)
            NSLayoutConstraint.activate([
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                titleLabel.centerYAnchor.constraint(equalTo:    contentView.centerYAnchor),
                toggle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                toggle.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
        }
        func configure(with item: TodoItem) {
            titleLabel.text = item.title
            toggle.isOn = item.isCompleted
            titleLabel.textColor = item.isCompleted ? .systemGray : .label
    }
        @objc private func didToggle() {
            onToggle?()
        }
    }
    

