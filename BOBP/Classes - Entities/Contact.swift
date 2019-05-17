//
//  Contact.swift
//  Auditions
//
//  Created by Warren O'Brien on 4/18/19.
//  Copyright © 2019 Warren O'Brien. All rights reserved.
//

import Foundation

class Contact {
    
    // Required Fields
    var contactID:Int
    var firstName:String
    var lastName:String
    
    // Optional Fields
    var phoneNumber1:String?
    var phoneNumber2:String?
    var phoneType1:String?
    var phoneType2:String?
    var phoneCanText1:Bool?
    var phoneCanText2:Bool?
    var emailAddress:String?
    var addressLine1:String?
    var addressLine2:String?
    var city:String?
    var state:String?
    var zipCode:String?
    var website:String?
    
    // Initializer
    init (contactID:Int, firstName:String, lastName:String) {
        self.contactID = contactID
        self.firstName = firstName
        self.lastName = lastName
    }
    
}
