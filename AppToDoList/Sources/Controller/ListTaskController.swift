//
//  ListTaskController.swift
//  AppToDoList
//
//  Created by Geovane Lima dos Santos on 29/11/24.
//

import UIKit

class ListTaskController: UIViewController {
    
    //MARK: IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnAdd: UIButton!
    
    //MARK: Var/Let
    private var list: [Task] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.registerNib()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.loadItens()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ManagerTasksController {
            guard let task = sender as? Task else {return}
            controller.task = task
        }
    }
    
    //MARK: Private/Public Func
    private func registerNib() {
        self.tableView.register(UINib(nibName: "EmptyTableViewCell", bundle: nil), forCellReuseIdentifier: "emptyTableCell")
    }
    
    private func loadItens() {
        self.list = TaskDefaultHelper().getListTask()
        self.tableView.reloadData()
    }
    
    private func callCreateTask(task: Task?) {
        self.performSegue(withIdentifier: "createNewTaskSegue", sender: task)
    }
    
    //MARK: Action
    @IBAction func addNewTask(_ sender: Any) {
        self.callCreateTask(task: nil)
    }

}

//MARK: UITableViewDataSource, UITableViewDelegate
extension ListTaskController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.list.count > 0 ? self.list.count : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.list.count > 0 {
            let cell: TaskTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cellTarefa", for: indexPath) as! TaskTableViewCell
            
            let task: Task = self.list[indexPath.row]
            
            cell.setTitle(title: task.titulo)
            cell.setDate(date: task.data)
            cell.setHour(hour: task.hora)
            
            return cell
        } else {
            let cell: EmptyTableViewCell = tableView.dequeueReusableCell(withIdentifier: "emptyTableCell", for: indexPath) as! EmptyTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.list.count > 0 ? 87 : 107
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.list.count > 0 {
            self.callCreateTask(task: self.list[indexPath.row])
        } else {
            self.callCreateTask(task: nil)
        }
    }
}
