//
//  common.swift
//  SwiftRadio
//
//  Created by Calogero Cascio on 17/08/18.
//  Copyright © 2018 matthewfecher.com. All rights reserved.
//

import Foundation
import UIKit
import MediaPlayer
import StoreKit
import CloudKit

class CommonFunctions {
    
    let launchCountUserDefaultsKey = "noOfLaunches"
    let numberOfRequests = "numberOfRequests"
    
    init() {
        
    }

    func getKeepaCC() -> Int {
        var cc: Int
        switch getCountry().lowercased() {
        case "com":
            cc = 1
        case "co.uk":
            cc = 2
        case "de":
            cc = 3
        case "co.jp":
            cc = 5
        case "fr":
            cc = 4
        case "ca":
            cc = 6
        case "it":
            cc = 8
        case "es":
            cc = 9
        default:
            cc = 1
        }
        return cc
    }
    func getCountry() -> String {
        let locale = Locale.current
        print(locale.regionCode as Any)
        return locale.regionCode!
    }

    func getImageURL(for image: UIImage?) -> URL {
        let documentsDirectoryPath:NSString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        let tempImageName = "tempImage.jpg"
        var imageURL: URL?

        if let image = image {

            let imageData:Data = image.jpegData(compressionQuality: 0.75)!
            let path:String = documentsDirectoryPath.appendingPathComponent(tempImageName)
            try? image.jpegData(compressionQuality: 0.75)!.write(to: URL(fileURLWithPath: path), options: [.atomic])
            imageURL = URL(fileURLWithPath: path)
            try? imageData.write(to: imageURL!, options: [.atomic])
        }
        return imageURL!
    }
    
    func readBarcode(barcode: String, type: String) -> Scanned {
        switch type {
        case "face":
            break
        case "org.iso.Aztec"://qr
            break
        case "org.iso.Code128":
            break
        case "org.iso.Code39":
            break
        case "org.iso.Code39Mod43":
            break
        case "com.intermec.Code93":
            break
        case "org.iso.DataMatrix"://qr
            break
        case "org.gs1.EAN-13":

            let countryCode = barcode[0..<3]
            if StoreStruct.barcodeCountry.filter({$0.key == countryCode}).count > 0 {
                let country = StoreStruct.barcodeCountry.filter {$0.key == countryCode}[0].value
                return Scanned(barcode: barcode, type: type, country: country, new: true, asin: "")
            }
        case "org.gs1.EAN-8":
            break
        case "org.ansi.Interleaved2of5":
            break
        case "org.gs1.ITF14":
            break
        case "org.iso.PDF417":
            break
        case "org.iso.QRCode":
            break
        case "org.gs1.UPC-E":
            break
        default:
            let countryCode = barcode[0..<3]
            if StoreStruct.barcodeCountry.filter({$0.key == countryCode}).count > 0 {
                let country = StoreStruct.barcodeCountry.filter {$0.key == countryCode}[0].value
                return Scanned(barcode: barcode, type: type, country: country, new: true, asin: "")
            }
        }
        return Scanned(barcode: barcode, type: type, country: "Unknown", new: true, asin: "")
    }
    /** Get UserDefaults value if its nil or no value found, set the value and there on increment ‘launchCount’ on every launch. **/
    func isReviewViewToBeDisplayed(minimumLaunchCount: Int) -> Bool {
        let launchCount = UserDefaults.standard.integer(forKey: launchCountUserDefaultsKey)
        let requestCount = UserDefaults.standard.integer(forKey: numberOfRequests) + 1
        
        if launchCount >= minimumLaunchCount * requestCount {
            UserDefaults.standard.set((requestCount), forKey: numberOfRequests)
            return true
        } else {
            /** Increase launch count by ‘1’ after every launch.**/
            UserDefaults.standard.set((launchCount + 1), forKey: launchCountUserDefaultsKey)
        }
        return false
    }
    
    /** This method is called from any class with minimum launch count needed. **/
    func showReviewView(afterMinimumLaunchCount: Int) {
        if #available(iOS 10.3, *) {
            if isReviewViewToBeDisplayed(minimumLaunchCount: afterMinimumLaunchCount) {
                SKStoreReviewController.requestReview()
            }
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getCacheDirectory() -> URL {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func moveFile(fromPath: String, toPath: String) {
        
        do {
            try FileManager.default.moveItem(atPath: fromPath, toPath: toPath)
            
        } catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
    
    func copyFile(fromPath: String, toPath: String) {
        
        do {
            try FileManager.default.copyItem(at: URL(fileURLWithPath: fromPath, isDirectory: false),
                                             to: URL(fileURLWithPath: toPath, isDirectory: false))

        } catch let error as NSError {
            print("Ooops! Something went wrong: \(error)")
        }
    }
    func roundCorners(object: UIView, tr: Bool?, tl: Bool?, br: Bool?, bl: Bool?, width: Int, height: Int) {
        
        var borders: UIRectCorner = []
        if tl! { borders.insert(.topLeft)}
        if tr! { borders.insert(.topRight)}
        if bl! { borders.insert(.bottomLeft)}
        if br! { borders.insert(.bottomRight)}

        let path = UIBezierPath(roundedRect: object.bounds, byRoundingCorners: borders, cornerRadii: CGSize(width: width, height: height))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
//        maskLayer.masksToBounds = true
        object.layer.mask = maskLayer
    }
    func setShadow(myView: UIView, radius: Int?, opacity: Float?, color: CGColor?) {
        myView.layer.masksToBounds = false
        myView.layer.shadowColor = color != nil ? color: UIColor.lightGray.cgColor
        myView.layer.shadowOpacity = opacity ?? 0.7
//        myView.layer.shadowPath = UIBezierPath(rect: myView.bounds).cgPath
        myView.layer.shadowOffset = CGSize(width: 3.0, height: 3.0)
        myView.layer.shadowRadius = CGFloat(radius ?? 7)
        
        let newView: UIView = UIView()
        newView.layer.masksToBounds = true
        newView.layer.borderWidth = 1
        newView.layer.borderColor = UIColor.lightGray.cgColor
        
        myView.addSubview(newView)
        newView.translatesAutoresizingMaskIntoConstraints = false
        newView.leadingAnchor.constraint(equalTo: myView.leadingAnchor).isActive = true
        newView.trailingAnchor.constraint(equalTo: newView.trailingAnchor).isActive = true
        newView.topAnchor.constraint(equalTo: newView.topAnchor).isActive = true
        newView.bottomAnchor.constraint(equalTo: newView.bottomAnchor).isActive = true
    }
//
//    func updateLockScreen(with track: Track?) {
//
//        // Define Now Playing Info
//        var nowPlayingInfo = [String: Any]()
//
//        if let image = track?.artworkImage {
//            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork.init(boundsSize: image.size, requestHandler: { (_) -> UIImage in
//                return image
//            })
//        }
//
//        if let artist = track?.artist {
//            nowPlayingInfo[MPMediaItemPropertyArtist] = artist
//        }
//
//        if let title = track?.title {
//            nowPlayingInfo[MPMediaItemPropertyTitle] = title
//        }
//
//        // Set the metadata
//        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
//    }
//
//    func updateLockScreen(with episode: Episode?) {
//
//        // Define Now Playing Info
//        var nowPlayingInfo = [String: Any]()
//
//        if let imageUrl = episode?.imageUrl {
//            let imageView: UIImageView = UIImageView()
//            imageView.pin_setImage(from: URL(string: imageUrl)) { (results) -> Void in
//                if results.image != nil {
//                    DispatchQueue.main.async {
//                        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork.init(boundsSize: results.image!.size, requestHandler: { (_) -> UIImage in
//                            return results.image!
//                        })
//                    }
//                }
//            }
//        }
//
//        if let artist = episode?.author {
//            nowPlayingInfo[MPMediaItemPropertyArtist] = artist
//        }
//
//        if let title = episode?.title {
//            nowPlayingInfo[MPMediaItemPropertyTitle] = title
//        }
//
//        // Set the metadata
//        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
//    }
//
//    func progressAlongAxis(_ pointOnAxis: CGFloat, _ axisLength: CGFloat) -> CGFloat {
//        let movementOnAxis = pointOnAxis / axisLength
//        let positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
//        let positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
//        return CGFloat(positiveMovementOnAxisPercent)
//    }
    
    func ensureRange<T>(value: T, minimum: T, maximum: T) -> T where T: Comparable {
        return min(max(value, minimum), maximum)
    }
    
    func showHelperCircle(view: UIView) {
        let center = CGPoint(x: view.bounds.width * 0.5, y: 200)
        let small = CGSize(width: 30, height: 30)
        let circle = UIView(frame: CGRect(origin: center, size: small))
        circle.layer.cornerRadius = circle.frame.width/2
        circle.backgroundColor = UIColor.white
        circle.layer.shadowOpacity = 0.8
        circle.layer.shadowOffset = CGSize()
        view.addSubview(circle)
        UIView.animate(
            withDuration: 0.5,
            delay: 0.25,
            options: [],
            animations: {
                circle.frame.origin.y += 200
                circle.layer.opacity = 0
        },
            completion: { _ in
                circle.removeFromSuperview()
        }
        )
    }
    
    func rateMyApp(completion: @escaping ((_ result: Bool) -> Void)) {
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/" + appId) else {
            completion(false)
            return
        }
        guard #available(iOS 10, *) else {
            completion(UIApplication.shared.openURL(url))
            return
        }
        UIApplication.shared.open(url)
        completion( true)
    }

    func share(desc: String, image: UIImage?, ui: UIViewController) {
        // Setting description
        let firstActivityItem = "Description you want.."

        // Setting url
        let secondActivityItem : NSURL = NSURL(string: "itms-apps://itunes.apple.com/app/" + appId)!

        // If you want to use an image
        let image : UIImage = image ?? UIImage(named: "AppImage")!
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)

        // This lines is for the popover you need to show in iPad
//        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)

        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)

        // Pre-configuring activity items
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading

        // Anything you want to exclude
//        activityViewController.excludedActivityTypes = [
//            UIActivity.ActivityType.postToWeibo,
//            UIActivity.ActivityType.print,
//            UIActivity.ActivityType.assignToContact,
//            UIActivity.ActivityType.saveToCameraRoll,
//            UIActivity.ActivityType.addToReadingList,
//            UIActivity.ActivityType.postToFlickr,
//            UIActivity.ActivityType.postToVimeo,
//            UIActivity.ActivityType.postToTencentWeibo,
//            UIActivity.ActivityType.postToFacebook
//        ]

        activityViewController.isModalInPresentation = true
        ui.present(activityViewController, animated: true, completion: nil)
    }
    
    func addBlur(view: UIView, cornerRadius: Int) {
        if !UIAccessibility.isReduceTransparencyEnabled {
            let blur: UIBlurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
            let effectView: UIVisualEffectView = UIVisualEffectView (effect: blur)
            effectView.frame = view.bounds
            effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            view.insertSubview(effectView, at: 0)
            view.clipsToBounds = true
            view.layer.cornerRadius = CGFloat(cornerRadius)
        }
    }
    
    func copyFilesFromBundleToDocumentsFolderWith(fileExtension: String, destFilename: String) {
        if let resPath = Bundle.main.resourcePath {
            do {
                let dirContents = try FileManager.default.contentsOfDirectory(atPath: resPath)
                let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
                let filteredFiles = dirContents.filter { $0.contains(fileExtension) }
                for fileName in filteredFiles {
                    if let documentsURL = documentsURL {
                        let sourceURL = Bundle.main.bundleURL.appendingPathComponent(fileName)
                        let destURL = documentsURL.appendingPathComponent(destFilename)
                        do { try FileManager.default.copyItem(at: sourceURL, to: destURL) } catch { }
                    }
                }
            } catch { }
        }
    }
    
    func verifyUrl(urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = NSURL(string: urlString) {
                return UIApplication.shared.canOpenURL(url as URL)
            }
        }
        return false
    }
    
    public func getData(from url: String, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: completion).resume()
    }

    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size

        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height

        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }

        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)

        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()

        return newImage
    }

    func stringify(json: Any, prettyPrinted: Bool = false) -> String {
        var options: JSONSerialization.WritingOptions = []
        if prettyPrinted {
            options = JSONSerialization.WritingOptions.prettyPrinted
        }

        do {
            let data = try JSONSerialization.data(withJSONObject: json, options: options)
            if let string = String(data: data, encoding: String.Encoding.utf8) {
                return string
            }
        } catch {
            print(error)
        }

        return ""
    }
}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    /// An `NSRange` that represents the full range of the string.
    
    var nsRange: NSRange {
        return NSRange(startIndex ..< endIndex, in: self)
    }
    
    /// Substring from `NSRange`
    ///
    /// - Parameter nsRange: `NSRange` within `utf16`.
    /// - Returns: Substring with the given `NSRange`, or `nil` if the range can't be converted.
    
    subscript(nsRange: NSRange) -> Substring? {
        guard let range = Range(nsRange, in: self) else { return nil }
        
        return self[range]
    }

    subscript(_ range: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        let end = index(start, offsetBy: min(self.count - range.lowerBound,
                                             range.upperBound - range.lowerBound))
        return String(self[start..<end])
    }
    subscript(_ range: CountablePartialRangeFrom<Int>) -> String {
        let start = index(startIndex, offsetBy: max(0, range.lowerBound))
        return String(self[start...])
    }
}



//class CustomHeader: UITableViewHeaderFooterView {
//    static let reuseIdentifer = "CustomHeaderReuseIdentifier"
//    let customLabel = UILabel.init()
//
//    override public init(reuseIdentifier: String?) {
//        super.init(reuseIdentifier: reuseIdentifier)
//
//        customLabel.font = UIFont.preferredFont(forTextStyle: .headline)
//        customLabel.translatesAutoresizingMaskIntoConstraints = false
//        self.contentView.addSubview(customLabel)
//
//        let margins = contentView.layoutMarginsGuide
//        customLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
//        customLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
//        customLabel.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
//        customLabel.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

extension String {
    
    var stripped: String {
        let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_")
        return self.filter {okayChars.contains($0) }
    }
}

extension Array where Element: Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()
        
        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }
        
        return result
    }
}

class MNGExpandedTouchAreaButton: UIButton {
    
    var margin: CGFloat = 1.0
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let area = self.bounds.insetBy(dx: -margin, dy: -margin)
        return area.contains(point)
    }
    
}

extension URLSession {
    func dataTask(with url: URL, result: @escaping (Result<(URLResponse, Data), Error>) -> Void) -> URLSessionDataTask {
        return dataTask(with: url) { (data, response, error) in
            if let error = error {
                result(.failure(error))
                return
            }
            guard let response = response, let data = data else {
                let error = NSError(domain: "error", code: 0, userInfo: nil)
                result(.failure(error))
                return
            }
            result(.success((response, data)))
        }
    }
}
