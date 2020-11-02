//
//  SpotListViewController.swift
//  SnacktacularTwo
//
//  Created by James Monahan on 11/2/20.
//

import UIKit

class SpotListViewController: UIViewController {
    
    var spots : Spots!
    @IBOutlet weak var sortSegmentedControl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        spots = Spots()
        tableView.delegate = self
        tableView.dataSource = self
        configureSegmentedControl()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        spots.loadData {
            self.tableView.reloadData()
        }
    }
    
    func configureSegmentedControl(){
        let orangeFontColor = [NSAttributedString.Key.foregroundColor : UIColor(named: "Primary Color") ?? UIColor.white]
        let whiteFontColor = [NSAttributedString.Key.foregroundColor : UIColor(named: "Primary Color") ?? UIColor.orange]
        sortSegmentedControl.setTitleTextAttributes(orangeFontColor, for: .selected)
        sortSegmentedControl.setTitleTextAttributes(whiteFontColor, for: .normal)
        sortSegmentedControl.layer.borderColor = UIColor.white.cgColor
        sortSegmentedControl.layer.borderWidth = 1.0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let destination = segue.destination as! SpotDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            destination.spot = spots.spotArray[selectedIndexPath.row]
        }
    }
    
}

extension SpotListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spots.spotArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SpotTableViewCell
        cell.nameLabel?.text = spots.spotArray[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
