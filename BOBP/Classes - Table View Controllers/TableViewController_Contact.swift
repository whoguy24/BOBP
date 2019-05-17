//
//  AuditionTableViewController.swift
//  Auditions
//
//  Created by Warren O'Brien on 3/30/19.
//  Copyright © 2019 Warren O'Brien. All rights reserved.
//

import UIKit
import CoreData

class TableViewController_Contact: UITableViewController {
    
    // MARK: - Properties
    
    // Define View Controller Identifier Properties
    var segueToDetail = "segueContactDetail"
    var tableCell = "contactCell"
    
    // Define String Properties for Alert Dialogs
    var stringNewTitle = "New Contact"
    var stringNewMessage = "Please give your new contact a name"
    var stringNewPlaceholderFirstName = "First Name"
    var stringNewPlaceholderLastName = "Last Name"
    var stringButtonCreate = "Add"
    var stringButtonCancel = "Cancel"
    
    // Define Object Properties
    var contact: Contact?
    var contacts = [Contact]()
    
    // MARK: - Load View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Update View Controller
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    // MARK: - Prepare View Controller Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToDetail {
            let detailController = segue.destination as! DetailViewController_Contact
            detailController.contact = sender as? Contact
        }
    }
    
    // MARK: - Table View
    
    // Initialize
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! TableViewCell_Contact
        let contactInstance = contacts[indexPath.row]
        cell.contactLabel.text = contactInstance.firstName + " " + contactInstance.lastName
        return cell
    }
    
    // Select
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let contact = contacts[indexPath.row]
        performSegue(withIdentifier: segueToDetail, sender: contact)
    }
    
    // Edit/Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            contacts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    // MARK: - IBActions
    
    // Add Button
    @IBAction func addContact(_ sender: Any) {
        let alertDialog = UIAlertController(title: stringNewTitle, message: stringNewMessage, preferredStyle: .alert)
        alertDialog.addTextField{(textfield:UITextField) in textfield.placeholder = self.stringNewPlaceholderFirstName}
        alertDialog.addTextField{(textfield:UITextField) in textfield.placeholder = self.stringNewPlaceholderLastName}
        alertDialog.addAction(UIAlertAction(title: stringButtonCreate, style: .default, handler: { (action:UIAlertAction) in
            let firstNameTextField = alertDialog.textFields?.first
            let lastNameTextField = alertDialog.textFields?.last
            if firstNameTextField?.text != "" && lastNameTextField?.text != ""  {
                let contact = Contact(contactID: self.contacts.count + 1, firstName: "", lastName: "")
                contact.firstName = firstNameTextField!.text!
                contact.lastName = lastNameTextField!.text!
                self.performSegue(withIdentifier: self.segueToDetail, sender: contact)
            }
            
        }))
        alertDialog.addAction(UIAlertAction(title: stringButtonCancel, style: .cancel, handler: nil))
        self.present(alertDialog, animated: true, completion: nil)
    }
    
}

