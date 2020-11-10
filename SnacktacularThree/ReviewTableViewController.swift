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
    
    @IBOutlet var starButtonCollection: [UIButton]!
    
    
    var review:Review!
    var spot: Spot!
    var rating = 0 {
        didSet {
            for starButton in starButtonCollection{
                let imageName = (starButton.tag < rating ? "star.fill" : "star")
                starButton.setImage(UIImage(systemName: imageName), for: .normal)
                starButton.tintColor = (starButton.tag < rating ? .systemRed : .darkText)
            }
            review.rating = rating
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard spot != nil else{
            print("Error: No spot passed to the class.")
            return
        }
        
        if review == nil{
            review = Review()
        }
        updateUserInterface()

    }
    
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else{
            navigationController?.popViewController(animated: true)
        }
    }
    
    func updateUserInterface(){
        nameLabel.text = spot.name
        addressLabel.text = spot.address
        reviewTitleField.text = review.title
        reviewTextView.text = review.text
        rating = review.rating
    }
    
    func updateFromUserInterface(){
        review.title = reviewTitleField.text!
        review.text = reviewTextView.text!
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
        updateFromUserInterface()
        review.saveData(spot: spot) { (success) in
            if success{
                self.leaveViewController()
            } else {
                print("Error: Can't unwind segue from Review because of review saving error.")
            }
        }
    }
    @IBAction func starButtonPressed(_ sender: UIButton) {
        rating = sender.tag + 1
    }
    
}
