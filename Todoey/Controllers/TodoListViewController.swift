//
//  ViewController.swift
//  Todoey
//
//  Created by Кристина Максимова on 28.03.2022.
//

import UIKit

class TodoListViewController: UITableViewController {

    let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("items.plist")
    
    var array = [DataModel]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
    }

    
    
    //MARK: - DataSourse
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath)
        cell.textLabel?.text = array[indexPath.row].title
        cell.accessoryType = array[indexPath.row].done ? .checkmark : .none
        return cell
    }

    //MARK: - Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        array[indexPath.row].done.toggle()
        saveItems()
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
                self.saveItems()
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
    
    func saveItems() {
        let encode = PropertyListEncoder()
        do {
            let data = try encode.encode(array)
            try data.write(to: filePath!)
        } catch {
            print(error.localizedDescription)
        }
        tableView.reloadData()
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: filePath!) {
            let decoder = PropertyListDecoder()
            do {
                array = try decoder.decode([DataModel].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        
    }
}


