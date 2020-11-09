//
//  ReviewTableViewController.swift
//  SnacktacularThree
//
//  Created by James Monahan on 11/9/20.
//

import UIKit

class ReviewTableViewController: UITableViewController {

    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var buttonsBackgroundView: UIView!
    @IBOutlet weak var postedByLabel: UILabel!
    @IBOutlet weak var reviewTitleField: UITextField!
    
    @IBOutlet weak var reviewDateaLabel: UILabel!
    
    @IBOutlet weak var reviewTextView: UITextView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else{
            navigationController?.popViewController(animated: true)
        }
    }

    @IBAction func reviewTitleChanged(_ sender: UITextField) {
    }
    @IBAction func reviewTitleDonePressed(_ sender: UITextField) {
    }
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
    }
    @IBAction func cancelButtonPressed(_ sender: Any) {
        leaveViewController()
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
    }
    
}
