// добавить анимацию добавления ячейки, добавить удалние
// разобраться как переключаться между ветками и добавить ветку с алерт контроллером

import UIKit

class TaskViewController: UITableViewController {
    
    private var taskList: [Task] = []
    private var cellID = "task"
    let context = StorageManager.shared.persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavigationBar()
        fetchData()
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
        let addTaskVC = NewTaskViewController()
        addTaskVC.modalPresentationStyle = .fullScreen
        present(addTaskVC, animated: true)
    }
    
    private func fetchData(){
        let fetchRequest = Task.fetchRequest()
        do{
            taskList = try context.fetch(fetchRequest)
        }
        catch {
            print(error.localizedDescription)
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
