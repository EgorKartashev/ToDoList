//
//  NewTaskViewController.swift
//  13_layoutWith ode + CoreData
//
//  Created by Егор on 05.03.2023.
//

import UIKit

class NewTaskViewController: UIViewController {
    
    private let context = StorageManager.shared.persistentContainer.viewContext

    private lazy var taskTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "New Task"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var saveButton: UIButton = {
        createButtom(
            with: "Save Task",
            andcolor: UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 194/255 ),
            action: UIAction{_ in
                self.save()
            })
    }()
    
    private lazy var cancelButton: UIButton = {
        createButtom(
            with: "Cancel",
            andcolor: .systemRed,
            action: UIAction{_ in
                self.dismiss(animated: true)
            })
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubViews(taskTextField, saveButton, cancelButton)
        setConstraints()
    }
    
    private func setupSubViews(_ subviews: UIView...){
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraints(){
        taskTextField.translatesAutoresizingMaskIntoConstraints = false // отключаем авторесайз для констрейнтов которые создадим сейчас
        NSLayoutConstraint.activate([
            taskTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            taskTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            taskTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            saveButton.topAnchor.constraint(equalTo: taskTextField.bottomAnchor, constant: 20),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            cancelButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
        
    }
    
    
    private func createButtom (with title: String, andcolor color: UIColor, action: UIAction) -> UIButton {
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.baseBackgroundColor = color
        
        var attributes = AttributeContainer()
        attributes.font = UIFont.boldSystemFont(ofSize: 18)
        buttonConfiguration.attributedTitle = AttributedString(title, attributes: attributes)
        
        return UIButton(configuration: buttonConfiguration, primaryAction: action)
    }
    
    private func save(){
        let task = Task(context: context)
        task.title = taskTextField.text
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
      //  StorageManager.shared.saveContext()
        dismiss(animated: true)
    }
    
}
