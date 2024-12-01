//
//  Tarefa.swift
//  AppToDoList
//
//  Created by Geovane Lima dos Santos on 01/12/24.
//

import Foundation

class Task: Codable {
    var id: Int
    var titulo: String
    var hora: String
    var data: String
    
    init(id: Int, titulo: String, hora: String, data: String) {
        self.id = id
        self.titulo = titulo
        self.hora = hora
        self.data = data
    }
}
