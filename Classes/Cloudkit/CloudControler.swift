//
//  CloudController.swift
//  EcObjectives
//
//  Created by Calogero Cascio on 25/04/17.
//  Copyright © 202' Calogero Cascio. All rights reserved.
//
import Foundation
import CloudKit
import Disk
import UIKit

protocol CloudControllerDelegate {
    func errorUpdating(error: NSError)
    func modelUpdated()
}

class CloudController {
    
    var delegate: CloudControllerDelegate?
    var container: CKContainer
    var publicDB: CKDatabase?
    var privateDB: CKDatabase?
    var record : CKRecord?
    var scanned: [Scanned]?

    let cf = CommonFunctions()
    
    init() {
        container = CKContainer.default()
        self.publicDB = container.publicCloudDatabase
        self.privateDB = container.privateCloudDatabase
    }
    
    func isICloudContainerAvailable() -> Bool {
        if let currentToken = FileManager.default.ubiquityIdentityToken {
            if kDebugLog { print (currentToken) }
            return true
        } else {
            return false
        }
    }

    func queryPhoto(tableName: String, column: String, id: String, isPrivate: Bool, completionHandler: @escaping (UIImage?) -> Void) {
        if self.isICloudContainerAvailable() {
            let predicate = NSPredicate(format: "recordName == %@", id)
            let query = CKQuery(recordType: tableName, predicate: predicate)
            if isPrivate {
                self.privateDB!.perform(query, inZoneWith: nil) { (results, error) -> Void in
                    if error != nil {
                        print("nun va" + error.debugDescription)
                        completionHandler(nil)
                    } else {
                        for record in results! {
                            if record.object(forKey: column) != nil {
                                let photoObj = record.object(forKey: column) as! CKAsset
                                let photo = UIImage(contentsOfFile: photoObj.fileURL!.path)
                                completionHandler(photo)
                            } else {
                                completionHandler(nil)
                            }
                        }
                    }
                }
            } else {
                self.publicDB!.perform(query, inZoneWith: nil) { (results, error) -> Void in
                    if error != nil {
                        print("nun va" + error.debugDescription)
                        completionHandler(nil)
                    } else {
                        for record in results! {
                            if record.object(forKey: column) != nil {
                                let photoObj = record.object(forKey: column) as! CKAsset
                                let photo = UIImage(contentsOfFile: photoObj.fileURL!.path)
                                completionHandler(photo)
                            } else {
                                completionHandler(nil)
                            }
                        }
                    }
                }
            }
        }
    }

    func savePhoto(record: CKRecord, photoColumn: String, photo: UIImage, isPrivate: Bool, completionHandler: @escaping (Void?) -> Void) {
        if self.isICloudContainerAvailable() {

            record[photoColumn] = CKAsset(fileURL: cf.getImageURL(for: StoreStruct.profile.photo))
            if !isPrivate {
                self.publicDB!.save(record, completionHandler: { (e, o) -> Void in
                    print("Saved!")
                    print(e?.recordID as Any)
                    print(o.debugDescription)
                })
            } else {
                self.privateDB!.save(record, completionHandler: { (e, o) -> Void in
                    print("Saved!")
                    print(e?.recordID as Any)
                    print(o.debugDescription)
                })
            }
        }
    }

    func saveProfile() {
        let recordId = CKRecord.ID(recordName: StoreStruct.profile.id!)
        if StoreStruct.profile.record != nil {
            record = StoreStruct.profile.record
        } else {
            record = CKRecord(recordType: "user", recordID: recordId)
        }
        setRecord(column: "lastname", value: StoreStruct.profile.lastname)
        setRecord(column: "firstname", value: StoreStruct.profile.firstname)
        setRecord(column: "bio", value: StoreStruct.profile.bio)
        setRecord(column: "email", value: StoreStruct.profile.email)
        setRecord(column: "phone", value: StoreStruct.profile.phone)
        setRecord(column: "username", value: StoreStruct.profile.username)
        self.privateDB!.save(record!, completionHandler: { (e, o) -> Void in
            print("Saved!")
            print(e?.recordID as Any)
        })

    }

    func deleteProfile() {
        if self.isICloudContainerAvailable() {
            if StoreStruct.profile.record != nil {
                record = StoreStruct.profile.record
                self.privateDB?.delete(withRecordID: record!.recordID) { _,_  in }
            }
        }
    }

    func saveCategories(publicRepo: Bool) {

        for c in StoreStruct.categories {
            if c.checked == true {
                if c.record != nil {
                    record = c.record
                } else {
                    record = CKRecord(recordType: "category")
                }

                setRecord(column: "name", value: c.name)
                setRecord(column: "checked", value: "true")
                record?["sort"] = c.sort
                if publicRepo {
                    self.publicDB!.save(record!, completionHandler: { (r, o) -> Void in
                        print("Saved!")
                        print(r?.recordID as Any)
                        print(o.debugDescription)
                    })
                } else {
                    self.privateDB!.save(record!, completionHandler: { (r, o) -> Void in
                        print("Saved!")
                        if r != nil {
                            print(r?.recordID as Any)
                            var c = StoreStruct.categories.filter({$0.name == r?.object(forKey: "name") as! String})[0]
                            c.record = r
                            StoreStruct.categories.removeAll(where: {$0.name == r?.object(forKey: "name") as! String})
                            StoreStruct.categories.append(c)
                            print(o.debugDescription)
                        }
                    })
                }
            } else {
                if c.record != nil {
                    self.privateDB!.delete(withRecordID: c.record!.recordID) { _,_ in }
                }
            }
            record = nil
        }

    }

    func deleteBarcode(barcode: String) {
        if self.isICloudContainerAvailable() {
            if StoreStruct.scanned.filter({$0.barcode == barcode})[0].record != nil {
                record = StoreStruct.scanned.filter({$0.barcode == barcode})[0].record
                self.privateDB?.delete(withRecordID: record!.recordID) { _,_  in }
            }
        }
    }

    func query(tableName: String, sortBy: String, filter: String, value: String, isPrivate: Bool, completionHandler: @escaping (Bool) -> Void) {
        if self.isICloudContainerAvailable() {
            let predicate:NSPredicate?
            switch tableName {
            case "scanned":
                if filter == "barcode" {
                    predicate = NSPredicate(format: "barcode == %@", value)
                } else {
                    predicate = NSPredicate(format: "category == %@", value)
                }
            case "category":
                if filter == "name" {
                    predicate = NSPredicate(format: "name == %@", value)
                } else {
                    predicate = NSPredicate(value: true)
                }
            case "user":
                predicate = NSPredicate(value: true)
            default:
                predicate = NSPredicate(format: "barcode == %@", value)

                break
            }

            let query = CKQuery(recordType: tableName, predicate: predicate!)
            if sortBy != "" {
                query.sortDescriptors = [NSSortDescriptor(key: sortBy, ascending: true)]
            }
            
            if !isPrivate {
                self.publicDB!.perform(query, inZoneWith: nil) { (results, error) -> Void in
                    if error != nil {
                        print("nun va" + error.debugDescription)
                        completionHandler(false)
                    } else {
                        if results?.count ?? 0 > 0 {
                            for record in results! {
                                switch tableName {
                                case "product":

                                    let product = Scanned(barcode: record.object(forKey: "barcode") as! String, type: record.object(forKey: "type") as! String, country: (record.object(forKey: "country") as? String)!, new: false, asin: (record.object(forKey: "asin") as? String)!)
                                    if record.object(forKey: "images") != nil {
                                        product.artworkUrl600 = (record.object(forKey: "images") as! Array)[0]
                                    }
                                    StoreStruct.product.removeAll(where: {$0.barcode == record.object(forKey: "barcode") as! String})
                                    StoreStruct.product.append(product)
                                case "category":
                                    if StoreStruct.categories.filter({$0.name == record.object(forKey: "name") as! String}).count == 0 {
                                        let cat = Category(name: record.object(forKey: "name") as! String, checked: record.object(forKey: "checked") as! String == "true" ? true:false, sort: Int(truncating: record.object(forKey: "sort") as! NSNumber))
                                        StoreStruct.categories.append(cat)
                                    }

                                default:
                                    break
                                }
                            }
                            completionHandler(true)
                        } else {
                            completionHandler(false)
                        }
                    }
                }
            } else {
                self.privateDB!.perform(query, inZoneWith: nil) { (results, error) -> Void in
                    if error != nil {
                        print("nun va" + error.debugDescription)
                        completionHandler(false)
                    } else {
                        for record in results! {
                            switch tableName {
                            case "scanned":
                                let scanned = Scanned(barcode: record.object(forKey: "barcode") as! String, type: record.object(forKey: "type") as! String, country: (record.object(forKey: "country") as? String)!, new: false, asin: record.object(forKey: "asin") as? String )

                                StoreStruct.scanned.append(scanned)
                            case "category":
                                if StoreStruct.categories.filter({$0.name == record.object(forKey: "name") as! String}).count == 0 {
                                    var cat = Category(name: record.object(forKey: "name") as! String, checked: record.object(forKey: "checked") as! String == "true" ? true:false, sort: Int(truncating: record.object(forKey: "sort") as! NSNumber))
                                    cat.record = record
                                    StoreStruct.categories.append(cat)
                                }
                            case "user":
                                var prof = Profile(lastname: record.object(forKey: "lastname") as? String ?? "", firstname: record.object(forKey: "firstname") as? String ?? "")
                                prof.record = record
                                prof.bio = record.object(forKey: "bio") as? String
                                prof.email = record.object(forKey: "email") as? String
                                prof.phone = record.object(forKey: "phone") as? String
                                prof.username = record.object(forKey: "username") as? String
                                if (record.object(forKey: "photo") as? CKAsset) != nil {
                                    guard let data = NSData(contentsOf: (record.object(forKey: "photo") as! CKAsset).fileURL!) else { return }
                                    prof.photo = UIImage(data: data as Data)
                                }
                                StoreStruct.profile = prof

                            default:
                                break
                            }
                        }
                        completionHandler(true)
                    }
                }
            }
        }
    }

    func updateScanned(record: CKRecord, name: String, json: Data?, vote: Int?, country: String?, publicRepo: Bool) {
        
        record.setValue(name, forKey: "name")
        if json != nil { record.setValue(String(data: json!, encoding: .utf8), forKey: "json") }
        if vote != nil { record.setValue(vote, forKey: "vote") }
        if country != nil { record.setValue(country, forKey: "country") }
        if StoreStruct.scanned.filter({$0.barcode == record.object(forKey: "barcode") as? String})[0].image != nil {
            record[.image] = CKAsset(fileURL: cf.getImageURL(for: StoreStruct.scanned.filter({$0.barcode == record.object(forKey: "barcode") as? String})[0].image!))

        }

        if publicRepo {
            self.publicDB!.save(record, completionHandler: { (_, _) -> Void in
                print("Saved!")
            })
        } else {
            self.privateDB!.save(record, completionHandler: { (_, _) -> Void in
                print("Saved!")
            })
        }
    
    }

    func saveProduct(barcode: String, publicRepo: Bool) {
        if StoreStruct.product.filter({$0.barcode == barcode})[0].record == nil {
            let recordId = CKRecord.ID(recordName: barcode)
            record = CKRecord(recordType: "scanned", recordID: recordId)
        } else {
            record = StoreStruct.product.filter({$0.barcode == barcode})[0].record
        }

        let s = StoreStruct.product.filter({$0.barcode == barcode})[0]
        setRecord(column: "actor", value: s.actor)
        setRecord(column: "artist", value: s.artist)
        setRecord(column: "artworkUrl600", value: s.artworkUrl600)
        setRecord(column: "asin", value: s.asin)
        setRecord(column: "audienceRating", value: s.audienceRating)
        setRecord(column: "author", value: s.author)
        setRecord(column: "barcode", value: s.barcode)
        setRecord(column: "brand", value: s.brand)
        setRecord(column: "category", value: s.category)
        setRecord(column: "color", value: s.color)
        setRecord(column: "country", value: s.country)
        setRecord(column: "desc", value: s.desc)
        setRecord(column: "description", value: s.description)
        setRecord(column: "director", value: s.director)
        if s.dislike != nil { record?[.dislike] = s.dislike }
        setRecords(column: "features", value: s.features)
        setRecord(column: "format", value: s.format)
        setRecord(column: "genre", value: s.genre)
        setRecord(column: "height", value: s.height)
        if s.image != nil {
            record![.image] = CKAsset(fileURL: cf.getImageURL(for: s.image!))
        }
        setRecords(column: "images", value: s.images)
        setRecord(column: "ingredients", value: s.ingredients)
        setRecord(column: "label", value: s.label)
        setRecord(column: "length", value: s.length)
        if s.like != nil { record?[.like] = s.like }
        setRecord(column: "manufacturer", value: s.manufacturer)
        setRecord(column: "model", value: s.model)
        setRecord(column: "mpn", value: s.mpn)
        setRecord(column: "nutrition_facts", value: s.nutrition_facts)
        if s.price != nil { record?[.price] = s.price }
        setRecord(column: "packageQuantity", value: s.packageQuantity)
        setRecord(column: "releaseDate", value: s.releaseDate)
        setRecord(column: "productName", value: s.productName)
        if s.promo != nil { record?[.promo] = s.promo }
        setRecord(column: "publisher", value: s.publisher)
        setRecord(column: "rating", value: s.rating)
        setRecord(column: "releaseDate", value: s.releaseDate)
        setRecords(column: "reviews", value: s.reviews)
        setRecord(column: "size", value: s.size)
//        setRecords(column: "stores", value: s.stores)
        setRecord(column: "studio", value: s.studio)
        setRecord(column: "title", value: s.title)
        setRecord(column: "url", value: s.url)
        setRecord(column: "weight", value: s.weight)
        setRecord(column: "width", value: s.width)
        setRecord(column: "brand", value: s.brand)
        setRecord(column: "author", value: s.author)
        setRecord(column: "type", value: s.type)

        if publicRepo {
            self.publicDB!.save(record!, completionHandler: { (rec, o) -> Void in
                let prod = StoreStruct.product.filter({$0.barcode == barcode})[0]
                prod.record = rec
                StoreStruct.product.removeAll(where: {$0.barcode == barcode})
                StoreStruct.product.append(prod)
                print("Saved!")
                print(rec?.recordID as Any)
                print(o.debugDescription)
            })
        } else {
            self.privateDB!.save(record!, completionHandler: { (rec, o) -> Void in
                let prod = StoreStruct.product.filter({$0.barcode == barcode})[0]
                prod.record = rec
                StoreStruct.product.removeAll(where: {$0.barcode == barcode})
                StoreStruct.product.append(prod)
                print("Saved!")
                print(rec?.recordID as Any)
                print(o.debugDescription)
            })
        }
    }

    func saveScan(publicRepo: Bool) {
        for scan in StoreStruct.scanned where scan.new {
            if StoreStruct.scanned.filter({$0.barcode == scan.barcode})[0].record == nil {
                let recordId = CKRecord.ID(recordName: scan.barcode)
                record = CKRecord(recordType: "scanned", recordID: recordId)
            } else {
                record = StoreStruct.product.filter({$0.barcode == scan.barcode})[0].record
            }

            let s = StoreStruct.product.filter({$0.barcode == scan.barcode})[0]
            setRecord(column: "actor", value: s.actor)
            setRecord(column: "artist", value: s.artist)
            setRecord(column: "artworkUrl600", value: s.artworkUrl600)
            setRecord(column: "asin", value: s.asin)
            setRecord(column: "audienceRating", value: s.audienceRating)
            setRecord(column: "author", value: s.author)
            setRecord(column: "barcode", value: s.barcode)
            setRecord(column: "brand", value: s.brand)
            setRecord(column: "category", value: "Your List")
            setRecord(column: "color", value: s.color)
            setRecord(column: "country", value: s.country)
            setRecord(column: "desc", value: s.desc)
            setRecord(column: "description", value: s.description)
            setRecord(column: "director", value: s.director)
            if s.dislike != nil { record?[.dislike] = s.dislike }
            setRecords(column: "features", value: s.features)
            setRecord(column: "format", value: s.format)
            setRecord(column: "genre", value: s.genre)
            setRecord(column: "height", value: s.height)
            if s.image != nil {
                record![.image] = CKAsset(fileURL: cf.getImageURL(for: s.image!))
            }
            setRecords(column: "images", value: s.images)
            setRecord(column: "ingredients", value: s.ingredients)
            setRecord(column: "label", value: s.label)
            setRecord(column: "length", value: s.length)
            if s.like != nil { record?[.like] = s.like }
            setRecord(column: "manufacturer", value: s.manufacturer)
            setRecord(column: "model", value: s.model)
            setRecord(column: "mpn", value: s.mpn)
            setRecord(column: "nutrition_facts", value: s.nutrition_facts)
            if s.price != nil { record?[.price] = s.price }
            setRecord(column: "packageQuantity", value: s.packageQuantity)
            setRecord(column: "releaseDate", value: s.releaseDate)
            setRecord(column: "productName", value: s.productName)
            if s.promo != nil { record?[.promo] = s.promo }
            setRecord(column: "publisher", value: s.publisher)
            setRecord(column: "rating", value: s.rating)
            setRecord(column: "releaseDate", value: s.releaseDate)
            setRecords(column: "reviews", value: s.reviews)
            setRecord(column: "size", value: s.size)
            //        setRecords(column: "stores", value: s.stores)
            setRecord(column: "studio", value: s.studio)
            setRecord(column: "title", value: s.title)
            setRecord(column: "url", value: s.url)
            setRecord(column: "weight", value: s.weight)
            setRecord(column: "width", value: s.width)
            setRecord(column: "brand", value: s.brand)
            setRecord(column: "author", value: s.author)
            setRecord(column: "type", value: s.type)

            if publicRepo {
                self.privateDB!.save(record!, completionHandler: { (rec, o) -> Void in
                    scan.new.toggle()
                    scan.record = rec
                    StoreStruct.scanned.removeAll(where: {$0.barcode == scan.barcode})
                    StoreStruct.scanned.append(scan)
                    print("Saved!")
                    print(rec?.recordID as Any)
                })
            } else {
                self.publicDB!.save(record!, completionHandler: { (rec, o) -> Void in
                    scan.new.toggle()
                    scan.record = rec
                    StoreStruct.scanned.removeAll(where: {$0.barcode == scan.barcode})
                    StoreStruct.scanned.append(scan)
                    print("Saved!")
                    print(rec?.recordID as Any)
                })
            }

        }
    }

    func setRecord(column: String, value: String?) {
        if value != nil && value != "" { record?[column] = value }
    }
    func setRecords(column: String, value: [String]?) {
        if value != nil && value!.count > 0 { record?[column] = value }
    }
}

extension CKRecord {
    enum ScannedRec: String {
        case barcode
        case type
        case productName
        case artworkUrl600
        case like
        case dislike
        case image
        case lv
        case dl
        case url
        case category
        case country
        case price
        case promo
        case rating
        case desc
        case new
        case mpn
        case model
        case asin
        case title
        case manufacturer
        case brand
        case label
        case author
        case publisher
        case artist
        case actor
        case director
        case studio
        case genre
        case audienceRating
        case ingredients
        case nutrition_facts
        case color
        case format
        case packageQuantity
        case size
        case length
        case width
        case height
        case weight
        case releaseDate
        case description
        case features
        case images
        case stores
        case reviews
    }
    subscript(key: ScannedRec) -> Any? {
        get {
            return self[key.rawValue]
        }
        set {
            self[key.rawValue] = newValue as? CKRecordValue
        }
    }

}
//actor
//artist
//artworkUrl600
//asin
//audienceRating
//author
//barcode
//brand
//category
//color
//country
//desc
//description
//director
//record?[.dislike] = s.dislike
//record?[.features] = s.features
//format
//genre
//height
//image
//Asset
//images
//ingredients
//label
//length
//like
//manufacturer
//model
//mpn
//nutrition_facts
//price
//packageQuantity
//releaseDate
//productName
//promo
//published
//rating
//releaseDate
//reviews
//size
//stores
//studio
//title
//url
//weight
//width
