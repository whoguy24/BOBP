
//
//  AuditionTableViewController.swift
//  Auditions
//
//  Created by Warren O'Brien on 3/30/19.
//  Copyright © 2019 Warren O'Brien. All rights reserved.
//

import UIKit
import Firebase

class TableViewController_Animal: UITableViewController {
    
    // MARK: - Properties
    
    // Define View Controller Identifier Properties
    var segueToDetail = "segueAnimalDetail"
    var tableCell = "animalCell"
    
    // Define String Properties for Alert Dialogs
    var stringNewTitle = "New Talent"
    var stringNewMessage = "Please name your new talent"
    var stringNewPlaceholder = "Name / Nickname"
    var stringButtonCreate = "Add"
    var stringButtonCancel = "Cancel"
    
    // Define Object Properties
    var animals = [Animal]()
    
    // Load Firestore Database Reference
     var database:Firestore!
    
    // MARK: - Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Firestore.firestore()
        loadData()
        checkForUpdates()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == segueToDetail {
            let detailController = segue.destination as! DetailViewController_Animal
            detailController.animal = sender as? Animal
        }
    }
    
    func loadData(){
        database.collection("Animal").getDocuments () {
            QuerySnapshot, error in
            if let error =  error {
                print("\(error.localizedDescription)")
            } else {
                self.animals = QuerySnapshot!.documents.compactMap({Animal(dictionary: $0.data())})
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func checkForUpdates() {
        database.collection("Animal").addSnapshotListener{
            QuerySnapshot, error in
            guard let snapshot = QuerySnapshot else {return}
            snapshot.documentChanges.forEach {
                update in
                
                if update.type == .added {
                    self.animals.append(Animal(dictionary: update.document.data())!)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
                if update.type == .modified {
                }
                
                if update.type == .removed {
                }
                
            }
        }
    }
    
    // MARK: - Table View
    
    // Initialize
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: tableCell, for: indexPath) as! TableViewCell_Animal
        let animalInstance = animals[indexPath.row]
        cell.animalLabel.text = animalInstance.name
        return cell
    }
    
    // Select
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let animal = animals[indexPath.row]
        performSegue(withIdentifier: segueToDetail, sender: animal)
    }
    
    // Edit/Delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            animals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
    
    // MARK: - IBActions
    
    // Add Button
    @IBAction func addAnimal(_ sender: Any) {
        let alertDialog = UIAlertController(title: stringNewTitle, message: stringNewMessage, preferredStyle: .alert)
        alertDialog.addTextField{(textfield:UITextField) in textfield.placeholder = self.stringNewPlaceholder}
        alertDialog.addAction(UIAlertAction(title: stringButtonCreate, style: .default, handler: { (action:UIAlertAction) in
            
            // Add to FireStore
                
            if let name = alertDialog.textFields?.first?.text {
                let newAnimal = Animal(contactID: "1", animalID: "1", name: name)
                
                var reference:DocumentReference? = nil
                reference = self.database.collection("Animal").addDocument(data: newAnimal.dictionary){
                    error in
                    if let error = error {
                        print("Error adding document: \(error.localizedDescription)")
                        
                    }else {
                        print("Document added with ID: \(reference!.documentID)")
                    }
                }
                
            }
            
            //self.performSegue(withIdentifier: self.segueToDetail, sender: self.animal)
            
        }))
        alertDialog.addAction(UIAlertAction(title: stringButtonCancel, style: .cancel, handler: nil))
        self.present(alertDialog, animated: true, completion: nil)
    }
    
}
