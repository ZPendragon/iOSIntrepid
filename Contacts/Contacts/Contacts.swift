//
//  Contacts.swift
//  Contacts
//
//  Created by Kevin Zeckser on 6/13/16.
//  Copyright © 2016 Kevin Zeckser. All rights reserved.
//

import Foundation

struct Contact {
    
    var name : String
    var phoneNumber: String
    
    // TODO: Add Features
    
//    var email : String?
//    var notes : String?
    
    init(name: String, phoneNumber: String) {
        self.name = name
        self.phoneNumber = phoneNumber
//        self.email = email
//        self.notes = notes
    }
    
}