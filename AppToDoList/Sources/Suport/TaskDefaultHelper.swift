//
//  TarefaDefaultHelper.swift
//  AppToDoList
//
//  Created by Geovane Lima dos Santos on 01/12/24.
//

import Foundation

class TaskDefaultHelper {
    
    let kTask: String = "kTarefa"
    
    public func saveListTask(lista: [Task]) {
        do {
            let listAux = try JSONEncoder().encode(lista)
            UserDefaults.standard.setValue(listAux, forKey: self.kTask)
        } catch {
            print(error)
        }
    }
    
    public func getListTask() -> [Task] {
        
        do {
            guard let lista = UserDefaults.standard.object(forKey: self.kTask) else {return []}
            
            let listAux = try JSONDecoder().decode([Task].self, from: lista as! Data)
              
            return listAux
        } catch {
            print(error)
            
        }
    
        return []
        
    }
    
    public func updateTask(task: Task) {
        var list: [Task] = self.getListTask()
        list.removeAll { taskList in
            return taskList.id == task.id
        }
        list.append(task)
        self.saveListTask(lista: list)
    }
    
    public func removeTask(task: Task) {
        var list: [Task] = self.getListTask()
        list.removeAll { taskList in
            return taskList.id == task.id
        }
        self.saveListTask(lista: list)
    }
    
    public func getNextId() -> Int {
        let list: [Task] = self.getListTask()
        for index in 0...list.count {
            let listAux = list.filter {$0.id == index}
            if listAux.count == 0 {
                return index
            }
        }
        return 0
    }
}
