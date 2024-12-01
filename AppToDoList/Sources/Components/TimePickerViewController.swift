//
//  TimePickerViewController.swift
//  AppToDoList
//
//  Created by Geovane Lima dos Santos on 29/11/24.
//

import UIKit

protocol TimePickerProtocol {
    func enviarHorario(horario: String)
}

class TimePickerViewController: UIViewController {

    //MARK: IBOutlet
    @IBOutlet weak var bntCancelar: UIButton!
    @IBOutlet weak var btnOK: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    //MAKR: Var/Lets
    public var delegate: TimePickerProtocol?
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: IBAction
    @IBAction func close(_ sender: UIButton) {
        if sender == self.btnOK {
            self.dismiss(animated: true) {
                guard let delegate = self.delegate else {return}
                let datePickerSelected: Date = self.datePicker.date
                
                let dateStr: String = Date().convertDateToString(date: datePickerSelected, dateFormatter: "HH:mm")

                delegate.enviarHorario(horario: dateStr)
            }
        } else {
            self.dismiss(animated: true)
        }
    }
    
}
