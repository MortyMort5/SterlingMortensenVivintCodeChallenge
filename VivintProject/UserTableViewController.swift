//
//  UserTableViewController.swift
//  VivintProject
//
//  Created by Sterling Mortensen on 5/11/17.
//  Copyright © 2017 Sterling Mortensen. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
    
    // LifeCycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        UserController.shared.fetchUsers("10") {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refetchUsers), for: UIControlEvents.valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    // IBActions
    @IBAction func fetchUsersButtonTapped(_ sender: Any) {
        guard let quantity = quantityTextField.text else { return }
        UserController.shared.fetchUsers(quantity) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: Any) {
        UserController.shared.deleteDataInPersistentStore {
            self.tableView.reloadData()
        }
    }
    
    // IBOutlets
    @IBOutlet weak var quantityTextField: UITextField!
    
    // Helper Functions    
    func refetchUsers() {
        UserController.shared.fetchUsers("10") {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    // Data Source Functions
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserController.shared.users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserTableViewCell else { return UITableViewCell() }
        let users = UserController.shared.users[indexPath.row]
        cell.users = users
        return cell
    }
}
