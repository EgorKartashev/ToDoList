// добавить анимацию добавления ячейки, добавить удалние
// разобраться как переключаться между ветками и добавить ветку с алерт контроллером

import UIKit

class TaskViewController: UITableViewController {
    
    private var taskList: [Task] = []
    private var cellID = "task"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchData()
        tableView.reloadData()
    }
    
    
    
    
    private func setupNavigationBar(){
        title = "Task List"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let navBerAppearance = UINavigationBarAppearance()
        navBerAppearance.configureWithOpaqueBackground()
        navBerAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navBerAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        navBerAppearance.backgroundColor = UIColor(
            red: 21/255,
            green: 101/255,
            blue: 192/255,
            alpha: 194/255
        )
        navigationController?.navigationBar.standardAppearance = navBerAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBerAppearance
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewTask))
        
        navigationController?.navigationBar.tintColor = .white
    }
    
    @objc private func addNewTask(){
        showAlert(with: "New Task", and: "What do you want to do?")
    }
    
    
    
    private func showAlert( with title: String, and message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let task = alert.textFields?.first?.text, !task.isEmpty else {return}
            self.save(task)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        alert.addTextField { textField in
            textField.placeholder = "New Task"
        }
        present(alert, animated: true)
    }
    
  
    
    private func fetchData(){
        StorageManager.shared.fetchData { result in
            switch result{
            case .success(let task):
                self.taskList = task
                print(self.taskList)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}


extension TaskViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        taskList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let task = taskList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.text = task.title
        cell.contentConfiguration = content
        return cell
    }
}
