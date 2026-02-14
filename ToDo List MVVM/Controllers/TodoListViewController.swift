//
//  TodoListViewController.swift
//  ToDo List MVVM
//
//  Created by Daler Xudoyarov on 14.12.2025.
//


import UIKit

    final class TodoListViewController: UIViewController {
        private let tableView = UITableView()
        private let viewModel = TodoListViewModel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "Список задач"
            view.backgroundColor = .systemBackground
            setupTable()
            setupNavigation()
            bind()
        }
        private func setupNavigation() {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                barButtonSystemItem: .add,
                target: self,
                action: #selector(addTapped)
            )
        }
        private func setupTable() {
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(TodoCell.self, forCellReuseIdentifier: TodoCell.identifier)
            tableView.dataSource = self
            tableView.delegate = self
            view.addSubview(tableView)
            NSLayoutConstraint.activate([
                tableView.topAnchor.constraint(equalTo: view.topAnchor),
                tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
        private func bind() {
            viewModel.onUpdate = { [weak self] in
                self?.tableView.reloadData()
            }
        }
        @objc private func addTapped() {
            let vc = AddTodoViewController()
            vc.onAdd = { [weak self] title in
                self?.viewModel.add(title: title)
            }
            navigationController?.pushViewController(vc, animated: true)
        }
    }

    extension TodoListViewController: UITableViewDataSource, UITableViewDelegate {
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            viewModel.items.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: TodoCell.identifier, for: indexPath) as! TodoCell
            let item = viewModel.items[indexPath.row]
            cell.configure(with: item)
            cell.onToggle = { [weak self] in
                self?.viewModel.toggle(at: indexPath.row)
            }
            return cell
        }
        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                viewModel.delete(at: indexPath.row)
            }
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            45
        }
    }
