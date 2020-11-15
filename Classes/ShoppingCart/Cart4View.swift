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

//TODO:  implement delegate to update the cart price as user press plus or minus
import UIKit

//-------------------------------------------------------------------------------------------------------------------------------------------------
class Cart4View: UIViewController {

	@IBOutlet var labelItemCount: UILabel!
	@IBOutlet var tableView: UITableView!
	@IBOutlet var layoutConstraintTableViewHeight: NSLayoutConstraint!
	@IBOutlet var labelSubTotal: UILabel!

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func viewDidLoad() {

		super.viewDidLoad()
		tableView.register(UINib(nibName: "Cart4Cell1", bundle: Bundle.main), forCellReuseIdentifier: "Cart4Cell1")

		loadData()
	}

	// MARK: - Data methods
	//---------------------------------------------------------------------------------------------------------------------------------------------
	func loadData() {

//TODO: remove this stub
        let dict1: Scanned? = Scanned(barcode: "1111", type: "", country: "", new: false, asin: "")
        dict1?.title = "Rezz Casual Sneaker"
        dict1?.promo = 54.99
        dict1?.price = 139.50
        dict1?.color = "Black"
        dict1?.size = "6.5 UK"
        StoreStruct.cart.append(dict1!)

        var price = 0.0
        for cart in StoreStruct.cart {
            price += (cart.promo == nil ? cart.price : cart.promo)!
        }
        labelItemCount.text = "Cart \(StoreStruct.cart.count) items"
        labelSubTotal.text = "$" + String(price)

		refreshTableView()
	}

	// MARK: - Refresh methods
	//---------------------------------------------------------------------------------------------------------------------------------------------
	func refreshTableView() {

		tableView.reloadData()
	}

	// MARK: - User actions
	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionCancel(_ sender: UIButton) {

		print(#function)
		dismiss(animated: true)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionClearAll(_ sender: UIButton) {

		print(#function)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@IBAction func actionCheckout(_ sender: UIButton) {

		print(#function)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionFavorite(_ sender: UIButton) {

		print(#function)
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	@objc func actionDelete(_ sender: UIButton) {

		print(#function)
	}
}

// MARK: - UITableViewDataSource
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension Cart4View: UITableViewDataSource {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func numberOfSections(in tableView: UITableView) -> Int {

		return 1
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        layoutConstraintTableViewHeight.constant = CGFloat(80*StoreStruct.cart.count)
        return StoreStruct.cart.count
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		let cell = tableView.dequeueReusableCell(withIdentifier: "Cart4Cell1", for: indexPath) as! Cart4Cell1
        cell.bindData(index: indexPath, data: StoreStruct.cart[indexPath.row])
		cell.buttonDelete.addTarget(self, action: #selector(actionDelete(_:)), for: .touchUpInside)
		return cell
	}
}

// MARK: - UITableViewDelegate
//-------------------------------------------------------------------------------------------------------------------------------------------------
extension Cart4View: UITableViewDelegate {

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

		return 80
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

		print(#function)
		tableView.deselectRow(at: indexPath, animated: true)
	}
}
