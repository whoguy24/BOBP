//
//  AuditionDetailTableViewController.swift
//  Auditions
//
//  Created by Warren O'Brien on 4/5/19.
//  Copyright © 2019 Warren O'Brien. All rights reserved.

import UIKit
import CoreData

class DetailViewController_Contact: UITableViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneNumber1Field: UITextField!
    @IBOutlet weak var phoneNumber2Field: UITextField!
    @IBOutlet weak var emailAddressField: UITextField!
    @IBOutlet weak var websiteField: UITextField!
    @IBOutlet weak var addressLine1Field: UITextField!
    @IBOutlet weak var addressLine2Field: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var stateField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    
    // MARK: - Properties
    
    // Define String Properties for Alert Dialogs
    var stringDeleteTitle = "Delete Contact"
    var stringDeleteMessage = "Are you sure you want to delete this contact?"
    var stringButtonDelete = "Delete"
    var stringButtonCancel = "Cancel"
    
    // Define Object Property
    var contact: Contact?
    
    // MARK: - Load View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set Text Fields With Object Properties
        firstNameField.text = contact?.firstName
        lastNameField.text = contact?.lastName
        phoneNumber1Field.text = contact?.phoneNumber1
        phoneNumber2Field.text = contact?.phoneNumber2
        emailAddressField.text = contact?.emailAddress
        websiteField.text = contact?.website
        addressLine1Field.text = contact?.addressLine1
        addressLine2Field.text = contact?.addressLine2
        cityField.text = contact?.city
        stateField.text = contact?.state
        zipCodeField.text = contact?.zipCode
        
        // Initialize Tap Gesture Recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    // MARK: - Dismiss View Controller
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        contact?.firstName = firstNameField.text!
        contact?.lastName = lastNameField.text!
        contact?.phoneNumber1 = phoneNumber1Field.text
        contact?.phoneNumber2 = phoneNumber2Field.text
        contact?.emailAddress = emailAddressField.text
        contact?.website = websiteField.text
        contact?.addressLine1 = addressLine1Field.text
        contact?.addressLine2 = addressLine2Field.text
        contact?.city = cityField.text
        contact?.state = stateField.text
        contact?.zipCode = zipCodeField.text
    }
    
    // MARK: - IBActions
    
    // Delete Button
    @IBAction func deleteContact(_ sender: Any) {
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
