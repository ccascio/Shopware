/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Batzo : Decodable {
	let barcode : String?
	let barcode_type : String?
	let mpn : String?
	let name : Name?
	let description : [Description]?
	let brand : String?
	let manufacturer : String?
	let aggregateRating : AggregateRating?
	let prices : [Prices]?
	let reviews : [Reviews]?

	enum CodingKeys: String, CodingKey {

		case barcode = "barcode"
		case barcode_type = "barcode_type"
		case mpn = "mpn"
		case name = "name"
		case description = "description"
		case brand = "brand"
		case manufacturer = "manufacturer"
		case aggregateRating = "aggregateRating"
		case prices = "prices"
		case reviews = "reviews"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		barcode = try values.decodeIfPresent(String.self, forKey: .barcode)
		barcode_type = try values.decodeIfPresent(String.self, forKey: .barcode_type)
		mpn = try values.decodeIfPresent(String.self, forKey: .mpn)
		name = try values.decodeIfPresent(Name.self, forKey: .name)
		description = try values.decodeIfPresent([Description].self, forKey: .description)
		brand = try values.decodeIfPresent(String.self, forKey: .brand)
		manufacturer = try values.decodeIfPresent(String.self, forKey: .manufacturer)
		aggregateRating = try values.decodeIfPresent(AggregateRating.self, forKey: .aggregateRating)
		prices = try values.decodeIfPresent([Prices].self, forKey: .prices)
		reviews = try values.decodeIfPresent([Reviews].self, forKey: .reviews)
	}

}
