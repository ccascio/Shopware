/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Products : Codable {
	let barcode_number : String?
	let barcode_type : String?
	let barcode_formats : String?
	let mpn : String?
	let model : String?
	let asin : String?
	let product_name : String?
	let title : String?
	let category : String?
	let manufacturer : String?
	let brand : String?
	let label : String?
	let author : String?
	let publisher : String?
	let artist : String?
	let actor : String?
	let director : String?
	let studio : String?
	let genre : String?
	let audience_rating : String?
	let ingredients : String?
	let nutrition_facts : String?
	let color : String?
	let format : String?
	let package_quantity : String?
	let size : String?
	let length : String?
	let width : String?
	let height : String?
	let weight : String?
	let release_date : String?
	let description : String?
	let features : [String]?
	let images : [String]?
	let stores : [Stores]?
	let reviews : [String]?

	enum CodingKeys: String, CodingKey {

		case barcode_number = "barcode_number"
		case barcode_type = "barcode_type"
		case barcode_formats = "barcode_formats"
		case mpn = "mpn"
		case model = "model"
		case asin = "asin"
		case product_name = "product_name"
		case title = "title"
		case category = "category"
		case manufacturer = "manufacturer"
		case brand = "brand"
		case label = "label"
		case author = "author"
		case publisher = "publisher"
		case artist = "artist"
		case actor = "actor"
		case director = "director"
		case studio = "studio"
		case genre = "genre"
		case audience_rating = "audience_rating"
		case ingredients = "ingredients"
		case nutrition_facts = "nutrition_facts"
		case color = "color"
		case format = "format"
		case package_quantity = "package_quantity"
		case size = "size"
		case length = "length"
		case width = "width"
		case height = "height"
		case weight = "weight"
		case release_date = "release_date"
		case description = "description"
		case features = "features"
		case images = "images"
		case stores = "stores"
		case reviews = "reviews"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		barcode_number = try values.decodeIfPresent(String.self, forKey: .barcode_number)
		barcode_type = try values.decodeIfPresent(String.self, forKey: .barcode_type)
		barcode_formats = try values.decodeIfPresent(String.self, forKey: .barcode_formats)
		mpn = try values.decodeIfPresent(String.self, forKey: .mpn)
		model = try values.decodeIfPresent(String.self, forKey: .model)
		asin = try values.decodeIfPresent(String.self, forKey: .asin)
		product_name = try values.decodeIfPresent(String.self, forKey: .product_name)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		category = try values.decodeIfPresent(String.self, forKey: .category)
		manufacturer = try values.decodeIfPresent(String.self, forKey: .manufacturer)
		brand = try values.decodeIfPresent(String.self, forKey: .brand)
		label = try values.decodeIfPresent(String.self, forKey: .label)
		author = try values.decodeIfPresent(String.self, forKey: .author)
		publisher = try values.decodeIfPresent(String.self, forKey: .publisher)
		artist = try values.decodeIfPresent(String.self, forKey: .artist)
		actor = try values.decodeIfPresent(String.self, forKey: .actor)
		director = try values.decodeIfPresent(String.self, forKey: .director)
		studio = try values.decodeIfPresent(String.self, forKey: .studio)
		genre = try values.decodeIfPresent(String.self, forKey: .genre)
		audience_rating = try values.decodeIfPresent(String.self, forKey: .audience_rating)
		ingredients = try values.decodeIfPresent(String.self, forKey: .ingredients)
		nutrition_facts = try values.decodeIfPresent(String.self, forKey: .nutrition_facts)
		color = try values.decodeIfPresent(String.self, forKey: .color)
		format = try values.decodeIfPresent(String.self, forKey: .format)
		package_quantity = try values.decodeIfPresent(String.self, forKey: .package_quantity)
		size = try values.decodeIfPresent(String.self, forKey: .size)
		length = try values.decodeIfPresent(String.self, forKey: .length)
		width = try values.decodeIfPresent(String.self, forKey: .width)
		height = try values.decodeIfPresent(String.self, forKey: .height)
		weight = try values.decodeIfPresent(String.self, forKey: .weight)
		release_date = try values.decodeIfPresent(String.self, forKey: .release_date)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		features = try values.decodeIfPresent([String].self, forKey: .features)
		images = try values.decodeIfPresent([String].self, forKey: .images)
		stores = try values.decodeIfPresent([Stores].self, forKey: .stores)
		reviews = try values.decodeIfPresent([String].self, forKey: .reviews)
	}

}