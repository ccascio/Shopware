/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Stores : Codable {
	let store_name : String?
	let store_price : String?
	let product_url : String?
	let currency_code : String?
	let currency_symbol : String?

	enum CodingKeys: String, CodingKey {

		case store_name = "store_name"
		case store_price = "store_price"
		case product_url = "product_url"
		case currency_code = "currency_code"
		case currency_symbol = "currency_symbol"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		store_name = try values.decodeIfPresent(String.self, forKey: .store_name)
		store_price = try values.decodeIfPresent(String.self, forKey: .store_price)
		product_url = try values.decodeIfPresent(String.self, forKey: .product_url)
		currency_code = try values.decodeIfPresent(String.self, forKey: .currency_code)
		currency_symbol = try values.decodeIfPresent(String.self, forKey: .currency_symbol)
	}

}