/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct BMonster : Codable {
	let classs : String?
	let code : String?
	let company : String?
	let description : String?
	let image_url : String?
	let size : String?
	let status : String?

	enum CodingKeys: String, CodingKey {

		case classs = "class"
		case code = "code"
		case company = "company"
		case description = "description"
		case image_url = "image_url"
		case size = "size"
		case status = "status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		classs = try values.decodeIfPresent(String.self, forKey: .classs)
		code = try values.decodeIfPresent(String.self, forKey: .code)
		company = try values.decodeIfPresent(String.self, forKey: .company)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
		size = try values.decodeIfPresent(String.self, forKey: .size)
		status = try values.decodeIfPresent(String.self, forKey: .status)
	}

}
