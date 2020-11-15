//
//  Scanned.swift
//  app
//
//  Created by Calogero Cascio on 12/09/2020.
//  Copyright © 2020 KZ. All rights reserved.
//

import Foundation
import UIKit
import CloudKit
//TODO: complete the list of attributes
class Scanned {
    var record: CKRecord?
    var barcode: String
    var type: String
    var productName: String?
    var artworkUrl600: String?
    var image: UIImage?
    var like: Int?
    var lv: Bool = false
    var dislike: Int?
    var dl: Bool = false
    var url: String?
    var category: String?
    var country: String?
    var price: Double?
    var promo: Double?
    var rating: String?
    var desc: String?
    var new: Bool = true
    var mpn = ""
    var model = ""
    var asin = ""
    var title = ""
    var manufacturer = ""
    var brand = ""
    var label = ""
    var author = ""
    var publisher = ""
    var artist = ""
    var actor = ""
    var director = ""
    var studio = ""
    var genre = ""
    var audienceRating = ""
    var ingredients = ""
    var nutrition_facts = ""
    var color = ""
    var format = ""
    var packageQuantity = ""
    var size = ""
    var length = ""
    var width = ""
    var height = ""
    var weight = ""
    var releaseDate = ""
    var description = ""
    var features:[String] = []
    var images:[String] = []
    var stores : [Stores]?
    var reviews:[String] = []

    init(barcode: String, type: String, country: String, new: Bool?, asin: String) {
        self.barcode = barcode
        self.type = type
        self.productName = ""
        self.artworkUrl600 = ""
        self.image = nil
        self.like = 0
        self.dislike = 0
        self.url = ""
        self.category = "default"
        self.country = country
        self.price = 0
        self.promo = 0
        self.rating = ""
        self.desc = ""
        self.new = new ?? true
        self.mpn = ""
        self.model = ""
        self.asin = ""
        self.title = ""
        self.manufacturer = ""
        self.brand = ""
        self.label = ""
        self.author = ""
        self.publisher = ""
        self.artist = ""
        self.actor = ""
        self.director = ""
        self.studio = ""
        self.genre = ""
        self.audienceRating = ""
        self.ingredients = ""
        self.nutrition_facts = ""
        self.color = ""
        self.format = ""
        self.packageQuantity = ""
        self.size = ""
        self.length = ""
        self.width = ""
        self.height = ""
        self.weight = ""
        self.releaseDate = ""
        self.description = ""
        self.features  = []
        self.images  = []
        self.stores = []
        self.reviews  = []
    }
}
