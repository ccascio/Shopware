//
//  Category.swift
//  app
//
//  Created by Calogero Cascio on 12/10/2020.
//  Copyright © 2020 KZ. All rights reserved.
//

import Foundation
import CloudKit

struct Category {
    var name : String = ""
    var checked : Bool = true
    var sort : Int = 0
    var record: CKRecord?

}
