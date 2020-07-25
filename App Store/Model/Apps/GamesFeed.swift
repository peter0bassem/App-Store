/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct GamesFeed : Codable {
	let title : String?
	let id : String?
	let author : GamesAuthor?
    let links : [[String:String]]?
	let copyright : String?
	let country : String?
	let icon : String?
	let updated : String?
	let results : [GamesResults]?

	enum CodingKeys: String, CodingKey {

		case title = "title"
		case id = "id"
		case author = "author"
		case links = "links"
		case copyright = "copyright"
		case country = "country"
		case icon = "icon"
		case updated = "updated"
		case results = "results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		title = try values.decodeIfPresent(String.self, forKey: .title)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		author = try values.decodeIfPresent(GamesAuthor.self, forKey: .author)
		links = try values.decodeIfPresent([[String:String]].self, forKey: .links)
		copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		icon = try values.decodeIfPresent(String.self, forKey: .icon)
		updated = try values.decodeIfPresent(String.self, forKey: .updated)
		results = try values.decodeIfPresent([GamesResults].self, forKey: .results)
	}

}
