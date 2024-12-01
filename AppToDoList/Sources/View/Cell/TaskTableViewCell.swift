//
//  TarefaTableViewCell.swift
//  AppToDoList
//
//  Created by Geovane Lima dos Santos on 29/11/24.
//

import UIKit

class TaskTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblData: UILabel!
    @IBOutlet weak var lblHora: UILabel!
    @IBOutlet weak var lblTitulo: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    public func setTitle(title: String) {
        self.lblTitulo.text = title
    }
    
    public func setDate(date: String) {
        self.lblData.text = date
    }
    
    public func setHour(hour: String) {
        self.lblHora.text = hour
    }

}
