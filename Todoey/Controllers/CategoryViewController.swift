//
//  CategoryViewController.swift
//  Todoey
//
//  Created by Кристина Максимова on 31.03.2022.
//

import UIKit
import CoreData

class CategoryViewController: UITableViewController {

    var categories = [Category]() {
        didSet {
            tableView.reloadData()
        }
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToItem", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! TodoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCategory = categories[indexPath.row]
        }
    }
    
    
    //MARK: - Main methods
    func loadCategories(with request: NSFetchRequest<Category> = Category.fetchRequest()) {
        do {
            categories = try context.fetch(request)
        } catch {
            print("Load categories error: \(error.localizedDescription)")
        }
    }
    
    func saveCategory() {
        do {
            try context.save()
        } catch {
            print("Save categories error: \(error.localizedDescription)")
        }
        tableView.reloadData()
    }

    //MARK: - Actions
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add new category?", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "Add category", style: .default) { act in
            if textField.text != "" {
                let category = Category(context: self.context)
                category.name = textField.text!
                self.categories.append(category)
                self.saveCategory()
            }
        }
        alert.addTextField { tf in
            tf.placeholder = "Create category"
            tf.clearButtonMode = .whileEditing
            textField = tf
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
