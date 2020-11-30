//
//  SnackViewController.swift
//  SnacktacularThree
//
//  Created by James Monahan on 11/29/20.
//

import UIKit

class SnackViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var snackUsers: SnackUsers!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        snackUsers = SnackUsers()
        snackUsers.loadData {
            self.tableView.reloadData()
        }
        
    }
    
}

extension SnackViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return snackUsers.userArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SnackTableViewCell
        cell.snackUser = snackUsers.userArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
