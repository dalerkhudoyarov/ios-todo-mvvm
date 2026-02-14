//
//  AddTodoViewController.swift
//  ToDo List MVVM
//
//  Created by Daler Xudoyarov on 14.12.2025.
//

import UIKit

final class AddTodoViewController: UIViewController, UITextFieldDelegate {

    var onAdd: ((String) -> Void)?
    private let textField = UITextField()
    private let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Новая задача"
        view.backgroundColor = .systemBackground
        setupUI()
        setupKeyboard()
    }

    private func setupUI() {
        textField.placeholder = "Введите задачу"
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        textField.delegate = self

        button.setTitle("Добавить", for: .normal)
        button.addTarget(self, action: #selector(addTapped), for: .touchUpInside)

        let stack = UIStackView(arrangedSubviews: [textField, button])
        stack.axis = .vertical
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    // MARK: - Keyboard setup

    private func setupKeyboard() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

    // Скрытие по нажатию - Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    // MARK: - Add Button

    @objc private func addTapped() {
        guard let text = textField.text, !text.isEmpty else { return }
        onAdd?(text)
        navigationController?.popViewController(animated: true)
    }
}
