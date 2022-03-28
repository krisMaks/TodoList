//
//  ViewController.swift
//  Todoey
//
//  Created by Кристина Максимова on 28.03.2022.
//

import UIKit

class TodoListViewController: UITableViewController {

    var array = [DataModel]() {
        didSet {
            print("reload")
            tableView.reloadData()
        }
    }
    let defalts = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item = DataModel()
        item.title = "Heo"
        array.append(item)
        
        let item2 = DataModel()
        item2.title = "Hello"
        array.append(item2)
        
        let item3 = DataModel()
        item3.title = "Hey"
        array.append(item3)
        
//        if let item = defalts.array(forKey: "TodoList") as? [DataModel] {
//            array = item
//        }
    }

    
    
    //MARK: - DataSourse
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row].title
        if array[indexPath.row].done == true {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }

    //MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        } else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
            
        array[indexPath.row].done.toggle()
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Actions
    
    @IBAction func addButtonPresssed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todoey item?", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Add item", style: .default) { alertAction in
            if textField.text != "" {
                let item = DataModel()
                item.title = textField.text!
                self.array.append(item)
                self.defalts.set(self.array, forKey: "TodoList")
            }
        }
        alert.addTextField { textF in
            textF.placeholder = "Create item"
            textF.clearButtonMode = .whileEditing
            textField = textF
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


