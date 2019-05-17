//
//  AuditionDetailTableViewController.swift
//  Auditions
//
//  Created by Warren O'Brien on 4/5/19.
//  Copyright © 2019 Warren O'Brien. All rights reserved.

import UIKit
import CoreData

class DetailViewController_Animal: UITableViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var breedField: UITextField!
    @IBOutlet weak var colorField: UITextField!
    @IBOutlet weak var genderField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var heightField: UITextField!
    @IBOutlet weak var lengthField: UITextField!
    @IBOutlet weak var girthField: UITextField!
    @IBOutlet weak var neckSizeField: UITextField!
    @IBOutlet weak var behaviorAttentionField: UITextView!
    @IBOutlet weak var behaviorStrangersField: UITextView!
    @IBOutlet weak var behaviorMiscField: UITextView!
    @IBOutlet weak var behaviorNoiseAdverseField: UISwitch!
    
    // MARK: - Properties
    
    // Define String Properties for Alert Dialogs
    var stringDeleteTitle = "Delete Talent"
    var stringDeleteMessage = "Are you sure you want to delete this talent?"
    var stringButtonDelete = "Delete"
    var stringButtonCancel = "Cancel"
    
    // Define Object Property
    var animal: Animal?
    
    // MARK: - Load View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Text Fields With Object Properties
        nameField.text = animal?.name
        
        /*
        breedField.text = animal?.breed
        colorField.text = animal?.color
        genderField.text = animal?.gender
        // ageField.text = String(animal?.age)
        // heightField.text = animal?.height
        // lengthField.text = animal?.length
        // girthField.text = animal?.girth
        // neckSizeField.text = animal?.neckSize
        behaviorAttentionField.text = animal?.behaviorAttention
        behaviorStrangersField.text = animal?.behaviorStrangers
        behaviorMiscField.text = animal?.behaviorMisc
        */
        
        // Initialize Tap Gesture Recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    // MARK: - Dismiss View Controller
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        animal?.name = nameField.text!
        
        /*
        animal?.breed = breedField.text
        animal?.color = colorField.text
        animal?.gender = genderField.text
        // animal?.age = ageField.text
        // animal?.height = heightField.text
        // animal?.length = lengthField.text
        // animal?.girth = girthField.text
        // animal?.neckSize = neckSizeField.text
        animal?.behaviorAttention = behaviorAttentionField.text
        animal?.behaviorStrangers = behaviorStrangersField.text
        animal?.behaviorMisc = behaviorMiscField.text
        */
    }
    
    // MARK: - IBActions
    
    // Delete Button
    @IBAction func deleteAnimal(_ sender: Any) {
        let alertDialog = UIAlertController(title: stringDeleteTitle, message: stringDeleteMessage, preferredStyle: .alert)
        let alertActionDelete = UIAlertAction(title: stringButtonDelete, style: .destructive) { (action:UIAlertAction!) in
            self.navigationController?.popViewController(animated: true)
        }
        let alertActionCancel = UIAlertAction(title: stringButtonCancel, style: .cancel) { (action:UIAlertAction!) in
        }
        alertDialog.addAction(alertActionDelete)
        alertDialog.addAction(alertActionCancel)
        self.present(alertDialog, animated: true, completion: nil)
    }
    
    // MARK: - OBJC Functions
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
}
