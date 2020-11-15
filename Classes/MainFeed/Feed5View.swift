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
class Feed5View: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var searchButton: UIButton!

    @IBOutlet var searchBar: UISearchBar!
	@IBOutlet var collectionViewMenu: UICollectionView!
	@IBOutlet var collectionViewPhotos: UICollectionView!
    @IBOutlet var cartButton: UIButton!

	private var selectedMenu = 0

    private var recents: [String] = StoreStruct.recents
    private var filtered:[String] = []
    private var unfiltered:[String] = []
    private var trendings: [Scanned] = StoreStruct.trendings ?? []
    private var filteredTrend: [Scanned]?
    private var unfilteredTrend: [Scanned]?

    @IBAction func search(_ sender: UIButton) {
        DispatchQueue.main.async {
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions.curveEaseIn, animations: {
//                self.barcodeHeight.constant = 25
//                self.searchButtonHeight.constant = 25
            }, completion: nil)
            self.searchButton.isHidden = true
            UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, animations: {
                self.searchBar.isHidden = false
            }, completion: nil)
        }
    }

    @IBAction func barcode(_ sender: Any) {
        let barcode = ScanViewController(nibName: "ScanViewController", bundle: Bundle.main)
        barcode.modalPresentationStyle = .fullScreen
        self.present(barcode, animated: true)
    }

    @IBAction func editProfile(_ sender: Any) {
        let editProfile = EditProfile1View(nibName: "EditProfile1View", bundle: Bundle.main)
//        editProfile.modalPresentationStyle = .formSheet
        navigationController?.pushViewController(editProfile, animated: true)
    }

    @IBAction func cart(_ sender: UIButton) {
        let cart4View = Cart4View()
        present(cart4View, animated: true)
    }
    //---------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		navigationController?.navigationBar.isHidden = true
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationItem.largeTitleDisplayMode = .never

		searchBar.layer.borderWidth = 1
		searchBar.layer.borderColor = UIColor.systemBackground.cgColor
        searchBar.delegate = self

		collectionViewMenu.register(UINib(nibName: "Feed5Cell1", bundle: Bundle.main), forCellWithReuseIdentifier: "Feed5Cell1")
		collectionViewPhotos.register(UINib(nibName: "Feed5Cell2", bundle: Bundle.main), forCellWithReuseIdentifier: "Feed5Cell2")
		collectionViewPhotos.collectionViewLayout = createLayout()

        loadData(top: 30, menu: "Your List", completionHandler: { (_) -> Void in
                print("loaded!")
            }
        )
	}

    override func viewWillAppear(_ animated: Bool) {
        searchButton.isHidden = false
//        searchBar.isHidden = true
//        stackView.distribution = UIStackView.Distribution.equalCentering
        let last = StoreStruct.scanned.count - 1
        if last >= 0 && last >= StoreStruct.scannedCount {
            StoreStruct.scannedCount  = last

            DispatchQueue.main.async {
                let post3DTouchView = Post3DTouchView(barcode: StoreStruct.scanned[last].barcode)
                self.present(post3DTouchView, animated: true)
            }
        }
    }
	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func viewWillDisappear(_ animated: Bool) {

		super.viewWillDisappear(animated)
		navigationController?.navigationBar.isHidden = false
	}

    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        searchBar.endEditing(true)
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        recents = unfiltered
        trendings = unfilteredTrend!

        if searchText.count > 0 {
            filtered = recents.filter({ (text) -> Bool in
                let tmp: NSString = text as NSString
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            recents = filtered

            filteredTrend = trendings.filter({$0.artworkUrl600!.lowercased().contains(searchText.lowercased())})
            trendings = filteredTrend!
        } else {
            recents = unfiltered
            trendings = unfilteredTrend!
        }

        refreshView(e: "photo", indexPath: nil)
    }

    func filterCat(_ searchBar: UISearchBar, textDidChange searchText: String) {
        recents = unfiltered
        trendings = unfilteredTrend!

        if searchText.count > 0 {
            filtered = recents.filter({ (text) -> Bool in
                let tmp: NSString = text as NSString
                let range = tmp.range(of: searchText, options: NSString.CompareOptions.caseInsensitive)
                return range.location != NSNotFound
            })
            recents = filtered

            filteredTrend = trendings.filter({$0.productName!.lowercased().contains(searchText.lowercased())})
            trendings = filteredTrend!
        } else {
            recents = unfiltered
            trendings = unfilteredTrend!
        }

        refreshView(e: "photo", indexPath: nil)
    }

    // MARK: - Refresh methods
    //---------------------------------------------------------------------------------------------------------------------------------------------
    func refreshView(e: String, indexPath: IndexPath?) {
        DispatchQueue.main.async {
            switch e {
            case "menu":
                StoreStruct.categories.sort { $0.sort < $1.sort }
                self.collectionViewMenu.reloadData()
                self.collectionViewMenu.reloadItems(at: self.collectionViewMenu.indexPathsForVisibleItems)
//                self.collectionViewMenu.scrollToItem(at: indexPath!, at: .centeredHorizontally, animated: true)
            case "photo":
                self.collectionViewPhotos.reloadData()
            default:
                self.collectionViewMenu.reloadData()
                self.collectionViewPhotos.reloadData()
                break
            }
        }
    }
	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

		super.traitCollectionDidChange(previousTraitCollection)
		searchBar.layer.borderColor = UIColor.systemBackground.cgColor
	}

	// MARK: - Data methods
	//---------------------------------------------------------------------------------------------------------------------------------------------
    func loadData(top: Int, menu: String, completionHandler: @escaping (Bool) -> Void) {
        var i = 0
        let cc = CloudController()
        if menu == "Your List" {

            cc.query(tableName: "category", sortBy: "sort", filter: "", value: "", isPrivate: true) {_ in
                if StoreStruct.categories.count == 0 {
                    cc.query(tableName: "category", sortBy: "sort", filter: "", value: "", isPrivate: false) {_ in
                        cc.saveCategories(publicRepo: false)
                        self.refreshView(e: "menu", indexPath: IndexPath(row: 1, section: 1))
                    }
                } else {
                    self.refreshView(e: "menu", indexPath: IndexPath(row: 1, section: 1))
                }
            }

            if StoreStruct.scanned.count > 0 {
                trendings.removeAll()
                for b in StoreStruct.scanned {
                    self.trendings.append(b)
                }

                unfilteredTrend = trendings
                self.refreshView(e: "photo", indexPath: nil)
                completionHandler(true)
            } else {
                trendings.removeAll()
                unfilteredTrend = trendings
                self.refreshView(e: "photo", indexPath: nil)
                completionHandler(true)
            }
        } else {

/*-->            To be removed: stubbed data*/
        i = top - 30
        while i < top {
            let t: Scanned = Scanned(barcode: "Social", type: "nil", country: "Italy", new: false, asin: "")
            trendings.append(t)
            i+=1
        }
 //<-- */
            unfilteredTrend = trendings
                        self.refreshView(e: "photo", indexPath: nil)
                        completionHandler(true)
            self.refreshView(e: "menu", indexPath: IndexPath(row: 1, section: 1))
        }
        unfilteredTrend = trendings
	}

	// MARK: - Helper Methods
	//---------------------------------------------------------------------------------------------------------------------------------------------
	func createLayout() -> UICollectionViewLayout {

		let layout = UICollectionViewCompositionalLayout {(sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in

			let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.665), heightDimension: .fractionalHeight(1.0)))
			leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)

			let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.3)))
			trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)

			let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.335), heightDimension: .fractionalHeight(1.0)), subitem: trailingItem, count: 2)

			let topBottomgItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0)))
			topBottomgItem.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)

			let topGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.25)), subitem: topBottomgItem, count: 3)
			let middleGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)), subitems: [trailingGroup, leadingItem])

			let mainGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.8)), subitems: [topGroup, middleGroup, topGroup])

			let section = NSCollectionLayoutSection(group: mainGroup)
			return section
		}
		return layout
	}
}

// MARK: - UICollectionViewDataSource
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension Feed5View: UICollectionViewDataSource {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func numberOfSections(in collectionView: UICollectionView) -> Int {

		return 1
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if (collectionView == collectionViewMenu) { return StoreStruct.categories.filter({$0.record != nil}).count }
        if (collectionView == collectionViewPhotos) { return trendings.count }
		return 0
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

		if (collectionView == collectionViewMenu) {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Feed5Cell1", for: indexPath) as! Feed5Cell1
            cell.bindData(title: StoreStruct.categories.filter({$0.record != nil})[indexPath.item].name)
			cell.set(isSelected: (selectedMenu == indexPath.row))
			return cell
		}

		if (collectionView == collectionViewPhotos) {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Feed5Cell2", for: indexPath) as! Feed5Cell2
			cell.bindData(index: indexPath)

			return cell
		}
		return UICollectionViewCell()
	}

    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in
            // Create an action for sharing
            var children: [UIAction]? = []

            if StoreStruct.cart.filter({(StoreStruct.scanned.count > indexPath.row && $0.barcode == StoreStruct.scanned[indexPath.row].barcode)
                                        || (StoreStruct.scanned.count > indexPath.row && $0.barcode == StoreStruct.product[indexPath.row].barcode)}).count == 0 {
                let addToList = UIAction(title: "Add to Shopping List", image: UIImage(systemName: "cart.fill.badge.plus")) { [self] action in

                    if selectedMenu == 0 {

                            StoreStruct.cart.append(StoreStruct.scanned[indexPath.row])

                    } else {
                        StoreStruct.cart.append(StoreStruct.product[indexPath.row])
                    }
                    cartButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)
                }
                children?.append(addToList)
            } else {
                let addToList = UIAction(title: "Remove from the list", image: UIImage(systemName: "cart.fill.badge.minus")) { [self] action in

                    if selectedMenu == 0 {

                        StoreStruct.cart.removeAll(where: {$0.barcode == StoreStruct.scanned[indexPath.row].barcode})

                    } else {
                        StoreStruct.cart.removeAll(where: {$0.barcode == StoreStruct.product[indexPath.row].barcode})
                    }
                    
                    if StoreStruct.cart.count > 0  {
                        cartButton.setImage(UIImage(systemName: "cart.fill"), for: .normal)

                    } else {
                        cartButton.setImage(UIImage(systemName: "cart"), for: .normal)

                    }
                }
                children?.append(addToList)
            }

            if self.selectedMenu != 0 {
            // Create an action for copy
                let copy = UIAction(title: "Copy to your list", image: UIImage(systemName: "doc.on.doc")) { [self] action in
    //                let editView = Comments2View(barcode: self.trendings[indexPath.row].barcode)
    //                self.present(editView, animated: true)
                    if self.selectedMenu != 0 {
                        StoreStruct.scanned.append(self.trendings[indexPath.row])
                    }
                }
                children?.append(copy)
            }
            // Create an action for delete with destructive attributes (highligh in red)
            let delete = UIAction(title: "Cancel", image: UIImage(systemName: "trash"), attributes: .destructive) { [self] action in
                if selectedMenu == 0 {
                    CloudController().deleteBarcode(barcode: self.trendings[indexPath.row].barcode)
                    StoreStruct.scanned.removeAll(where: {$0.barcode == self.trendings[indexPath.row].barcode})
                } else {
                    StoreStruct.product.removeAll(where: {$0.barcode == self.trendings[indexPath.row].barcode})
                }
                self.trendings.remove(at: indexPath.row)
            }
            children?.append(delete)
            // Create a UIMenu with all the actions as children
            return UIMenu(title: "", children: children!)
        }
    }
}

// MARK: - UICollectionViewDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension Feed5View: UICollectionViewDelegate {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

		print("didSelectItemAt \(indexPath.row)")

		if (collectionView == collectionViewMenu) {
			selectedMenu = indexPath.row
            loadData(top: 30, menu: StoreStruct.categories.filter({$0.record != nil})[selectedMenu].name, completionHandler: { (_) -> Void in
            })
            collectionView.scrollToItem(at:indexPath, at: .centeredHorizontally, animated: true)
		}
		if (collectionView == collectionViewPhotos) {
            DispatchQueue.main.async {
                StoreStruct.product.removeAll(where: {$0.barcode == self.trendings[indexPath.row].barcode})
                StoreStruct.product.append(self.trendings[indexPath.row])
                let post3DTouchView = Post3DTouchView(barcode: self.trendings[indexPath.row].barcode)
                self.present(post3DTouchView, animated: true)
            }
		}
	}
}

// MARK: - UICollectionViewDelegateFlowLayout
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension Feed5View: UICollectionViewDelegateFlowLayout {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
	//---------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

		if (collectionView == collectionViewMenu) {
            let textWidth = StoreStruct.categories[indexPath.row].name.uppercased().width(withConstrainedHeight: 25, font: UIFont.boldSystemFont(ofSize: 24))
			return CGSize(width: textWidth, height: collectionView.frame.size.height-25)
		}

		return CGSize.zero
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {

		if (collectionView == collectionViewMenu) { return 10	}
		if (collectionView == collectionViewPhotos) { return 1	}

		return 0
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {

		if (collectionView == collectionViewMenu) { return 10	}
		if (collectionView == collectionViewPhotos) { return 1	}

		return 0
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

		if (collectionView == collectionViewMenu) { return UIEdgeInsets(top: 10, left: 15, bottom: 15, right: 15) }
		if (collectionView == collectionViewPhotos) { return UIEdgeInsets.zero }

		return UIEdgeInsets.zero
	}
}

// MARK: - String
//-------------------------------------------------------------------------------------------------------------------------------------------------
fileprivate extension String {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {

		let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
		return ceil(boundingBox.height)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {

		let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
		let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
		return ceil(boundingBox.width)
	}
}
