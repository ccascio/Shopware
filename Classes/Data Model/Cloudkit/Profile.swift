//
//  Profile.swift
//  app
//
//  Created by Calogero Cascio on 11/10/2020.
//  Copyright © 2020 KZ. All rights reserved.
//

import UIKit
import CloudKit

struct Profile {
    var id: String?
    var record: CKRecord?
    var lastname: String?
    var firstname: String?
    var bio: String?
    var photo: UIImage?
    var phone: String?
    var username: String?
    var email: String?

    init(lastname: String, firstname: String) {
        self.lastname = lastname
        if lastname == "" {
            self.lastname = ""
        } else {
            self.lastname = lastname
        }
        if firstname == "" {
            self.firstname = ""
        } else {
            self.firstname = firstname
        }
        self.id = KeychainItem.currentUserIdentifier
        self.bio = ""
        self.phone = ""
        self.username = ""
        self.email = ""
        self.photo = nil
    }
}
