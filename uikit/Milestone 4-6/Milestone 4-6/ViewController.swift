//
//  ViewController.swift
//  Milestone 4-6
//
//  Created by Clément Villanueva on 10/07/2022.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptItem))
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearShoppingList))
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Item", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    @objc func promptItem() {
        let ac = UIAlertController(title: "Add", message: nil, preferredStyle: .alert)
        ac.addTextField()

        let submitAction = UIAlertAction(title: "OK", style: .default) {
            [unowned self, ac] action in
            let answer = ac.textFields![0]
            self.submit(answer.text!)
        }

        ac.addAction(submitAction)

        present(ac, animated: true)
    }
    
    func submit(_ item: String) {
        let lastRow = shoppingList.count
        
        shoppingList.insert(item, at: lastRow)
        tableView.insertRows(at: [IndexPath(row: lastRow, section: 0)], with: .automatic)
    }
    
    @objc func clearShoppingList() {
        shoppingList = [String]()
        tableView.reloadData()
    }

}

