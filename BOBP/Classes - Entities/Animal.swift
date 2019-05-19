//
//  Animal.swift
//  Auditions
//
//  Created by Warren O'Brien on 4/18/19.
//  Copyright © 2019 Warren O'Brien. All rights reserved.
//

import Foundation
import Firebase

protocol DocumentSerializable {
    init?(dictionary:[String:Any])
}

struct Animal {
    
    // Required Fields
    var contactID:String
    var animalID:String
    var name:String
    
    /*
    // Optional Fields
    var species:String?
    var breed: String?
    var gender: String?
    var color: String?
    var age:Int?
    var height:Int?
    var width:Int?
    var length:Int?
    var girth:Int?
    var neckSize:Int?
    var behaviorAttention: String?
    var behaviorStrangers: String?
    var behaviorMisc: String?
    var behaviorAttentionComments: String?
    var behaviorStrangersComments: String?
    var behaviorMiscComments: String?
    var noiseAdverse: Bool?
    */
    
    var dictionary:[String:Any] {
        return [
            "contactID":contactID,
            "animalID":animalID,
            "name":name
        ]
    }
    
}

extension Animal:DocumentSerializable {
    init? (dictionary: [String:Any]) {
        guard
            let contactID = dictionary["contactID"] as? String,
            let animalID = dictionary["animalID"] as? String,
            let name = dictionary["name"] as? String
            else {return nil}
        self.init(contactID: contactID, animalID: animalID, name: name)
    }
}
