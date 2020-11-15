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
class Cart4Cell1: UITableViewCell {

	@IBOutlet var imageProduct: UIImageView!
	@IBOutlet var labelTitle: UILabel!
	@IBOutlet var labelQuantity: UILabel!
	@IBOutlet var labelPrice: UILabel!
	@IBOutlet var labelOriginalPrice: UILabel!
	@IBOutlet var buttonDelete: UIButton!
    @IBOutlet var minus: UIButton!
    @IBOutlet var plus: UIButton!

	//---------------------------------------------------------------------------------------------------------------------------------------------
	override func awakeFromNib() {

		super.awakeFromNib()


		buttonDelete.layer.borderWidth = 1
		buttonDelete.layer.borderColor = AppColor.Border.cgColor
	}

	//---------------------------------------------------------------------------------------------------------------------------------------------
	func bindData(index: IndexPath, data: Scanned) {

        let title = data.title
        guard let price = data.promo == nil ? data.price : data.promo else { return }
        guard let originalPrice = data.promo == nil ? 0 : data.price else { return }
        let quantity = data.packageQuantity
        minus.setTitle(data.barcode, for: .disabled)
        plus.setTitle(data.barcode, for: .disabled)

        buttonDelete.setTitle(data.barcode, for: .disabled)
//		guard let color = data["color"] else { return }
//		guard let quantity = data["quantity"] else { return }
//		guard let size = data["size"] else { return }
        labelQuantity.text = quantity
		imageProduct.sample("Ecommerce", "Shoes", index.row+15)
		labelTitle.text = title
		labelPrice.text = "$" + String(price)
        labelOriginalPrice.text = String(originalPrice)
		labelOriginalPrice.isHidden = (originalPrice == 0)
//		labelQuantity.text = "QTY: " + quantity
	}

    @IBAction func deleteFromCart(_ sender: UIButton) {
        StoreStruct.cart.removeAll(where: {$0.barcode == sender.title(for: .disabled)})
    }

    @IBAction func plus(_ sender: UIButton) {
        let barcode = sender.title(for: .disabled)
        let cartItem = StoreStruct.cart.filter({$0.barcode==barcode})[0]
        cartItem.packageQuantity = String(Double(StoreStruct.cart.filter({$0.barcode==barcode})[0].packageQuantity) ?? 0 + 1)
        updateCartitem(item: cartItem)

        let price = cartItem.price ?? 0 * (Double(cartItem.packageQuantity) ?? 0 + 1)
        let originalPrice = cartItem.promo ?? 0 * (Double(cartItem.packageQuantity) ?? 0 + 1)

        labelQuantity.text = "qty: " + cartItem.packageQuantity
        labelPrice.text = "$" + String(price)
        labelOriginalPrice.text = String(originalPrice)
        labelOriginalPrice.isHidden = (originalPrice == 0)
    }

    @IBAction func minus(_ sender: UIButton) {
        let barcode = sender.title(for: .disabled)
        let cartItem = StoreStruct.cart.filter({$0.barcode==barcode})[0]
        cartItem.packageQuantity = String(Double(StoreStruct.cart.filter({$0.barcode==barcode})[0].packageQuantity) ?? 0 - 1)
        updateCartitem(item: cartItem)

        let price = cartItem.price ?? 0 * (Double(cartItem.packageQuantity) ?? 0 - 1)
        let originalPrice = cartItem.promo ?? 0 * (Double(cartItem.packageQuantity) ?? 0 - 1)

        labelQuantity.text = "qty: " + cartItem.packageQuantity
        labelPrice.text = "$" + String(price)
        labelOriginalPrice.text = String(originalPrice)
        labelOriginalPrice.isHidden = (originalPrice == 0)
    }

    func updateCartitem(item: Scanned) {
        StoreStruct.cart.removeAll(where: {$0.barcode==item.barcode})
        StoreStruct.cart.append(item)
    }
}
