//
//  ManageTasksController.swift
//  AppToDoList
//
//  Created by Geovane Lima dos Santos on 29/11/24.
//

import UIKit
import FSCalendar

class ManagerTasksController: UITableViewController {

    // MARK: IBOutlets
    
    @IBOutlet weak var txtTitle: UITextField!
    
    @IBOutlet weak var calendar: FSCalendar!
    
    @IBOutlet weak var btnHour: UIButton!
    
    @IBOutlet weak var btnRemove: UIButton!
    
    
    //MARK: Var/Let
    private var hour: String = ""
    private var date: String = ""
    public var task: Task?
    
    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.calendar.delegate = self
        self.configView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? TimePickerViewController {
            controller.delegate = self
        }
    }
    
    // MARK: IBActions
    @IBAction func goBack(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func abrirComponente(_ sender: Any) {
        self.performSegue(withIdentifier: "segueComponenteHora", sender: nil)
    }
    
    @IBAction func excluirTarefa(_ sender: Any) {
        TaskDefaultHelper().removeTask(task: self.task!)
        self.dismiss(animated: true)
    }
    
    @IBAction func criarTarefa(_ sender: Any) {
        self.createTarefa()
    }
    
    //MARK: Func
    
    private func configView() {
        self.btnRemove.isHidden = self.task == nil
        guard let taskAux = self.task else {return}
        self.btnHour.setTitle(taskAux.hora, for: .normal)
        self.txtTitle.text = taskAux.titulo
        self.date = taskAux.data
        self.hour = taskAux.hora
        
    }
    
    
    private func createTarefa() {
        
        if self.task != nil {
            self.task!.data = self.date
            self.task!.hora = self.hour
            self.task!.titulo = self.txtTitle.text!
            
            TaskDefaultHelper().updateTask(task: self.task!)
        } else {
            var list: [Task] = TaskDefaultHelper().getListTask()
            let tarefa: Task = Task(id: TaskDefaultHelper().getNextId(), titulo: self.txtTitle.text ?? "Sem título", hora: self.hour, data: self.date)
            
            list.append(tarefa)
            TaskDefaultHelper().saveListTask(lista: list)
        }
    
        self.dismiss(animated: true)
    }
    
}

extension ManagerTasksController: FSCalendarDelegate, FSCalendarDelegateAppearance {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.date = Date().convertDateToString(date: date, dateFormatter: "dd/MM/yyyy")
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let dateAux = Date().convertDateToString(date: date, dateFormatter: "dd/MM/yyyy")
        if self.task != nil {
            if self.date == dateAux {
                return .green
            }
        }
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let dateAux = Date().convertDateToString(date: date, dateFormatter: "dd/MM/yyyy")
        if self.task != nil {
            if self.date == dateAux {
                return .black
            }
        }
        return nil
    }
}


extension ManagerTasksController: TimePickerProtocol {
    func enviarHorario(horario: String) {
        self.btnHour.setTitle(horario, for: .normal)
        self.hour = horario
    }
}


extension ManagerTasksController {
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
}
