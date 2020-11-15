//
// Copyright (c) 2020 Related Code - http://relatedcode.com
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit
//-------------------------------------------------------------------------------------------------------------------------------------------------
class Post3DTouchView: UIViewController {

    var barcode: String?
    var url: String?
    var product: Scanned?
    var fdTakeController = FDTakeController()

    @IBOutlet var viewMain: UIView!
	@IBOutlet var imageUser: UIImageView!
	@IBOutlet var productName: UILabel!
	@IBOutlet var country: UILabel!
	@IBOutlet var imagePost: UIImageView!
    @IBOutlet var pictureButton: UIButton!
    @IBOutlet weak var Author: UILabel!
    @IBOutlet weak var Title1: UILabel!
    @IBOutlet weak var Ingredients: UILabel!
    @IBOutlet var cart: UIButton!

    @IBAction func cart(_ sender: UIButton) {
        if cart.currentImage == UIImage(systemName: "cart.badge.plus") {
            StoreStruct.cart.append(product!)
            cart.setImage(UIImage(systemName: "cart.fill.badge.minus"), for: .normal)
        } else {
            StoreStruct.cart.removeAll(where: {$0.barcode == product!.barcode})
            cart.setImage(UIImage(systemName: "cart.bagde.plus"), for: .normal)
        }
    }

    @IBAction func pictureButton(_ sender: UIButton) {

        resetFDTakeController()
        fdTakeController.presentingView = sender
        fdTakeController.present()

    }

    init(barcode: String) {
        super.init(nibName: "Post3DTouchView", bundle: nil)
        self.barcode = barcode
        product = StoreStruct.product.filter({$0.barcode == self.barcode})[0]

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //---------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
//        self.languageLabel.text = NSLocale.preferredLanguages.first!
		let interaction = UIContextMenuInteraction(delegate: self)
		viewMain.addInteraction(interaction)
        pictureButton.isHidden = true
		loadData()
	}

	// MARK: - Data methods
	//---------------------------------------------------------------------------------------------------------------------------------------------
	func loadData() {

//        self.imageUser.image = UIImage(named: "barcode")
        self.productName.text = product!.productName == "" ? "Unknown" : product!.productName
        self.country.text = product?.country == "" ? "Unknown" : product!.country
        self.url = product!.url
        if product?.image == nil && product?.images != nil && (product?.images.count)! > 0 {
            self.imagePost.imageFromUrl(url: (product?.images[0])!)
        }

        let cc = CloudController()
        cc.query(tableName: "scanned", sortBy: "", filter: "barcode", value: barcode!, isPrivate: false) { (success) in
            DispatchQueue.main.async { [self] in
                if success == true {
                    let product = StoreStruct.product.filter({ $0.barcode == self.barcode })[0]
                    self.imageUser.image = UIImage(named: "cloud.fill")
                    self.productName.text = product.productName == "" ? "Unknown" : product.productName
                    self.country.text = product.country == "" ? "Unknown" : product.country
                    self.imagePost.layer.backgroundColor = UIColor.black.cgColor
                    self.url = product.url
                    if product.artworkUrl600! != "" {
                        self.imagePost.imageFromUrl(url: product.artworkUrl600!)
                        self.pictureButton.isHidden = true
                    } else {
//                        self.imagePost.image = self.imagePost.textToImage(drawText: product.barcode as NSString, inImage: self.imagePost.image!, atPoint: CGPoint(x: 10, y: 20))
                        self.pictureButton.isHidden = false
                    }
                } else {
                    if self.barcode!.count > 8 {
                        let group: DispatchGroup =  .init()

//                        if product?.type == "org.gs1.UPC-E" ||
//                        product?.type == "org.gs1.EAN-13" ||
//                            product?.country == "Bookland" {

                            group.enter()
                            self.keepaAPI(barcode: self.barcode!) { (success) in
                                group.leave()
                            }
//                        }
//                        group.enter()
//                        bLookupAPI(barcode: self.barcode!) { (success) in
//                            group.leave()
//                        }
                        group.enter()
                        self.nutritionix(barcode: self.barcode!) { (success) in
                            group.leave()
                        }
                        group.enter()
                        self.bMonsterAPI(barcode: self.barcode!) { (success) in
                            group.leave()
                        }
                        group.enter()
                        self.batzoAPI(barcode: self.barcode!) { (success) in
                            group.leave()
                        }

                        group.notify(queue: .main) {
                            CloudController().saveProduct(barcode: self.barcode!, publicRepo: true)
                            let product = StoreStruct.product.filter({ $0.barcode == self.barcode })[0]
                            self.imageUser.image = UIImage(named: "cloud.fill")
                            self.productName.text = product.productName == "" ? "Unknown" : product.productName
                            self.country.text = product.country == "" ? "Unknown" : product.country
                            self.imagePost.layer.backgroundColor = UIColor.black.cgColor
                            self.url = product.url

                            if product.artworkUrl600! != "" {
                                self.imagePost.imageFromUrl(url: product.artworkUrl600!)
                                self.pictureButton.isHidden = true
                            } else {
                                //                        self.imagePost.image = self.imagePost.textToImage(drawText: product.barcode as NSString, inImage: self.imagePost.image!, atPoint: CGPoint(x: 10, y: 20))
                                self.pictureButton.isHidden = false
                            }
                        }
                    } else {
                        let product = StoreStruct.product.filter({ $0.barcode == self.barcode })[0]
                        self.imageUser.image = UIImage(named: "cloud.fill")
                        self.productName.text = product.productName == "" ? "Unknown" : product.productName
                        self.country.text = product.country == "" ? "Unknown" : product.country
                        self.imagePost.layer.backgroundColor = UIColor.black.cgColor
                        self.url = product.url
                        if product.artworkUrl600! != "" {
                            self.imagePost.imageFromUrl(url: product.artworkUrl600!)
                            self.pictureButton.isHidden = true
                        } else {
                            //                        self.imagePost.image = self.imagePost.textToImage(drawText: product.barcode as NSString, inImage: self.imagePost.image!, atPoint: CGPoint(x: 10, y: 20))
                            self.pictureButton.isHidden = false
                        }
                    }
                }
            }
        }
	}

    //https://rapidapi.com/msilverman/api/nutritionix-nutrition-database
    private func nutritionix(barcode: String, completion: @escaping (Bool?) -> ()) -> () {
        let headers = [
            "x-rapidapi-host": "nutritionix-api.p.rapidapi.com",
            "x-rapidapi-key": "616755b4d1mshed47902f8e77ae9p125d3ejsn9efa2988e9ab"
        ]

        var request = URLRequest(url: NSURL(string: "https://nutritionix-api.p.rapidapi.com/v1_1/search/cheddar%2520cheese?fields=item_name%252Citem_id%252Cbrand_name%252Cnf_calories%252Cnf_total_fat")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let task = URLSession.shared.dataTask(with: request) { data,result,error in
            if let error = error {
                print("Error took place \(error)")
                completion(false)
                return
            }

            // Convert HTTP Response Data to a simple String
            if let data = data {
                let output: Nutritionix = try! JSONDecoder().decode(Nutritionix.self, from: data)
                if output.item_id != nil {
                    DispatchQueue.main.async {
                        if self.productName.text != nil && self.productName.text == "" {
                            self.productName.text = output.brand_name
                        }
//                        CloudController().saveScanned(barcode: self.barcode!, publicRepo: true)
                    }
                }
            }
            completion(true)
        }
        task.resume()
    }

    //https://rapidapi.com/jonata/api/barcode-monster/endpoints
    private func bMonsterAPI (barcode: String, completion: @escaping (Bool?) -> ()) -> () {
        let headers = [
            "x-rapidapi-host": "barcode-monster.p.rapidapi.com",
            "x-rapidapi-key": "616755b4d1mshed47902f8e77ae9p125d3ejsn9efa2988e9ab"
        ]

        var request = URLRequest(url: NSURL(string: "https://barcode-monster.p.rapidapi.com/code")! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let task = URLSession.shared.dataTask(with: request) { data,result,error in
            if let error = error {
                print("Error took place \(error)")
                completion(false)
                return
            }

            // Convert HTTP Response Data to a simple String
            if let data = data {
                let output: BMonster = try! JSONDecoder().decode(BMonster.self, from: data)
                if output.code != nil {
                    DispatchQueue.main.async {
                        if self.productName.text != nil && self.productName.text == "" {
                            self.productName.text = output.company
                        }
                        if output.image_url != nil {
                            self.pictureButton.isHidden = true
                            self.imagePost.imageFromUrl(url: output.image_url!)
                        }
                    }
                }
            }
            completion(true)
        }
        task.resume()
    }

    //https://www.batzo.net/en/business/barcode-api/documentation
    private func keepaAPI (barcode: String, completion: @escaping (Bool?) -> ()) -> () {
        let url = URL(string: "https://keepa.com/product?key="+keepaAPIKey+"&domain=" +
                        String( CommonFunctions().getKeepaCC() ) + "&type=product&code=719192603691")//+barcode)

        let task = URLSession.shared.dataTask(with: url!) { data,result,error in
            if let error = error {
                print("Error took place \(error)")
                completion(false)
                return
            }

            let result = result as! HTTPURLResponse
            switch result.statusCode {
            case 400: completion(false); return
            case 403: completion(false); return
            case 404: completion(false); return
            case 429: completion(false); return
            default: break
            }

            if let data = data {
                let output: Keepa = try! JSONDecoder().decode(Keepa.self, from: data)

                self.product?.asin = (output.products?[0].asin!)!
                self.product?.audienceRating = output.products?[0].audienceRating ?? ""
                self.product?.author = output.products?[0].author ?? ""
                self.product?.brand = output.products?[0].brand ?? ""
                self.product?.category = String( output.products?[0].rootCategory ?? 1)
                self.product?.color = output.products?[0].color ?? ""
                self.product?.description = output.products?[0].description ?? ""
                self.product?.features = [output.products?[0].features ?? ""]
                self.product?.format = output.products?[0].format ?? ""
                self.product?.height = String(output.products?[0].packageHeight ?? 1)
                self.product?.length = String(output.products?[0].packageLength ?? 1)
                self.product?.images = [output.products?[0].imagesCSV ?? ""]
                let i = UIImage()
                i.imageFromUrl(url: output.products?[0].imagesCSV ?? "")
                self.product?.image = i
                self.product?.features = [output.products?[0].features ?? ""]
                self.product?.format = output.products?[0].format ?? ""
                self.product?.genre = String(output.products?[0].productType ?? 1)
                self.product?.like = 0
                self.product?.lv = true
                self.product?.manufacturer = output.products?[0].manufacturer ?? ""
                self.product?.model = output.products?[0].model ?? ""
                self.product?.productName = output.products?[0].title ?? ""
                self.product?.packageQuantity = String( output.products?[0].numberOfItems ?? 1)
                self.product?.publisher = output.products?[0].manufacturer ?? ""
                self.product?.author = output.products?[0].author ?? ""
                self.product?.releaseDate = String(output.products?[0].releaseDate ?? 1)
                self.product?.size = output.products?[0].size ?? ""
                self.product?.title = output.products?[0].title ?? ""

                DispatchQueue.main.async {
                    self.productName.text = output.products?[0].title
                    //                        self.country.text = output.products?[0].country
                    self.imagePost.layer.backgroundColor = UIColor.black.cgColor
//                    if output.products?[0].images != nil && output.products?[0].images!.count > 0 {
//                        self.pictureButton.isHidden = true
//                        self.imagePost.imageFromUrl(url: output.products?[0].images![0])
//                    }
                }
                completion(true)

            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    //https://www.batzo.net/en/business/barcode-api/documentation
    private func bLookupAPI (barcode: String, completion: @escaping (Bool?) -> ()) -> () {
        let url = URL(string: "https://api.barcodelookup.com/v2/products?barcode="+barcode+"&formatted=y&key="+bLookup)!

        let task = URLSession.shared.dataTask(with: url) { data,result,error in
            if let error = error {
                print("Error took place \(error)")
                completion(false)
                return
            }

            let result = result as! HTTPURLResponse
            switch result.statusCode {
            case 400: completion(false); return
            case 403: completion(false); return
            case 404: completion(false); return
            case 429: completion(false); return
            default: break
            }

            if let data = data {
                let output: BLookup = try! JSONDecoder().decode(BLookup.self, from: data)
                if output.products != nil {
                    self.product?.actor = output.products![0].actor!
                    self.product?.artist = output.products![0].artist!
                    self.product?.asin = output.products![0].asin!
                    self.product?.audienceRating = output.products![0].audience_rating!
                    self.product?.author = output.products![0].author!
                    self.product?.brand = output.products![0].brand!
                    self.product?.category = output.products![0].category!
                    self.product?.color = output.products![0].color!
                    self.product?.description = output.products![0].description!
                    self.product?.director = output.products![0].director!
                    self.product?.features = output.products![0].features!
                    self.product?.format = output.products![0].format!
                    self.product?.genre = output.products![0].genre!
                    self.product?.height = output.products![0].height!
                    self.product?.images = output.products![0].images!
                    let i = UIImage()
                    i.imageFromUrl(url: output.products![0].images![0])
                    self.product?.image = i
                    self.product?.features = output.products![0].features!
                    self.product?.format = output.products![0].format!
                    self.product?.genre = output.products![0].genre!
                    self.product?.height = output.products![0].height!
                    self.product?.ingredients = output.products![0].ingredients!
                    self.product?.label = output.products![0].label!
                    self.product?.length = output.products![0].length!
                    self.product?.like = 0
                    self.product?.lv = true
                    self.product?.manufacturer = output.products![0].manufacturer!
                    self.product?.model = output.products![0].model!
                    self.product?.mpn = output.products![0].mpn!
                    self.product?.nutrition_facts = output.products![0].nutrition_facts!
                    self.product?.productName = output.products![0].product_name!
                    self.product?.packageQuantity = output.products![0].package_quantity!
                    self.product?.publisher = output.products![0].publisher!
                    self.product?.reviews = output.products![0].reviews!
                    self.product?.releaseDate = output.products![0].release_date!
                    self.product?.size = output.products![0].size!
                    self.product?.studio = output.products![0].studio!
                    self.product?.stores = output.products![0].stores!
                    self.product?.title = output.products![0].title!
                    self.product?.width = output.products![0].width!
                    self.product?.weight = output.products![0].weight!

                    DispatchQueue.main.async {
                        self.productName.text = output.products![0].product_name
                        //                        self.country.text = output.products![0].country
                        self.imagePost.layer.backgroundColor = UIColor.black.cgColor
                        if output.products![0].images != nil && output.products![0].images!.count > 0 {
                            self.pictureButton.isHidden = true
                            self.imagePost.imageFromUrl(url: output.products![0].images![0])
                        }
                    }
                    completion(true)
                }
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    //https://www.batzo.net/en/business/barcode-api/documentation
    private func batzoAPI (barcode: String, completion: @escaping (Bool) -> ()) -> () {
        let url = URL(string: "https://www.batzo.net/api/v1/products?barcode="+barcode+"&key="+batzooAPIKey)!

        let task = URLSession.shared.dataTask(with: url) { (result) in
            switch result {
            case .success((_ , let data)):
                let output = try! JSONDecoder().decode(Batzo.self, from: data)
                if output.barcode != nil {
                    DispatchQueue.main.async {
                        self.productName.text = output.name?.en
                        self.country.text = output.brand
                        self.pictureButton.isHidden = false
                    }
                }
                completion(true)
                break
            case .failure( _):
                completion(false)
                // Handle Error
                break
            }
        }
        task.resume()
    }

    private func resetFDTakeController () -> Void {

        fdTakeController.didDeny = {
            let alert = UIAlertController(title: "Denied", message: "User did not select a photo/video", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        fdTakeController.didCancel = {

        }
        fdTakeController.didFail = {
            let alert = UIAlertController(title: "Failed", message: "User selected but API failed", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        fdTakeController.didGetPhoto = {
            (photo: UIImage, info: [AnyHashable : Any]) -> Void in
            let alert = UIAlertController(title: "Got photo", message: "User selected photo", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

            self.imagePost.image = CommonFunctions().resizeImage(image: photo, targetSize: CGSize(width: 1300, height: 1300))
            self.pictureButton.isHidden = true

            let editView = Post2View(barcode: self.barcode!)
            self.present(editView, animated: true)
        }
    }
    @IBAction func showMenu(_ sender: UILongPressGestureRecognizer) {
        
    }
}

// MARK: - UIContextMenuInteractionDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension Post3DTouchView: UIContextMenuInteractionDelegate {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {

		return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in

            var children: [UIAction]? = []

            let actionComment = UIAction(title: "Comment", image: UIImage(systemName: "text.bubble.fill")) { action in
                print("Comment")
                let commentView = AddCommentView(barcode: self.barcode!)
                self.present(commentView, animated: true)
            }
            children?.append(actionComment)

            if self.product?.productName != "" {
                let edit = UIAction(title: "Learn More", image: UIImage(systemName: "link")) { action in
                    print("Edit")
                    self.product?.image = self.imagePost.image
                    StoreStruct.product.removeAll(where: {$0.barcode == self.barcode})
                    StoreStruct.product.append(self.product!)
                    let editView = Post2View(barcode: self.barcode!)
                    self.present(editView, animated: true)
                }
                children?.append(edit)
            }

            if self.product?.url != "" {
                let actionLearnMore = UIAction(title: "Browse", image: UIImage(systemName: "square.and.arrow.up")) { action in
                    print("Learn More 1")
                    guard let url = URL(string: self.url!) else {
                        return //be safe
                    }

                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    } else {
                        UIApplication.shared.openURL(url)
                    }
                }
                children?.append(actionLearnMore)
            }

            let actionLike = UIAction(title: "Like", image: UIImage(systemName: "hand.thumbsup.fill")) { action in
                print("Like")
                if StoreStruct.product.filter({$0.barcode == self.barcode}).count > 0 {
                    let product = StoreStruct.product.filter({$0.barcode == self.barcode})[0]
                    if product.lv {

                    } else {

                        product.like! += 1
                        product.lv = true
                        StoreStruct.scanned.removeAll(where: {$0.barcode == self.barcode})
                        StoreStruct.scanned.append(product)
                        StoreStruct.product.removeAll(where: {$0.barcode == self.barcode})
                        StoreStruct.product.append(product)
                    }
                }
            }
            children?.append(actionLike)

            let actionDislike = UIAction(title: "Dislike", image: UIImage(systemName: "hand.thumbsdown.fill")) { action in
                print("Like")
                if StoreStruct.product.filter({$0.barcode == self.barcode}).count > 0 {
                    let product = StoreStruct.product.filter({$0.barcode == self.barcode})[0]
                    if product.lv {

                    } else {

                        product.like! -= 1
                        product.lv = true
                        StoreStruct.scanned.removeAll(where: {$0.barcode == self.barcode})
                        StoreStruct.scanned.append(product)
                        StoreStruct.product.removeAll(where: {$0.barcode == self.barcode})
                        StoreStruct.product.append(product)
                        
                    }
                }
            }
            children?.append(actionDislike)

			let actionShare = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
				print("Share")
                CommonFunctions().share(desc: self.product?.productName ?? "", image: self.product?.image, ui: self)
			}
            children?.append(actionShare)

			let actionReport = UIAction(title: "Report", image: UIImage(systemName: "exclamationmark.circle.fill")) { action in
				print("Report")
			}
            children?.append(actionReport)

			return UIMenu(title: "", children: children!)
		}
	}
}
