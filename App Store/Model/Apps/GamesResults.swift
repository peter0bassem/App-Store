/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct GamesResults : Codable {
	let artistName : String?
	let id : String?
	let releaseDate : String?
	let name : String?
	let kind : String?
	let copyright : String?
	let artistId : String?
	let artistUrl : String?
	let artworkUrl100 : String?
	let genres : [GamesGenres]?
	let url : String?

	enum CodingKeys: String, CodingKey {

		case artistName = "artistName"
		case id = "id"
		case releaseDate = "releaseDate"
		case name = "name"
		case kind = "kind"
		case copyright = "copyright"
		case artistId = "artistId"
		case artistUrl = "artistUrl"
		case artworkUrl100 = "artworkUrl100"
		case genres = "genres"
		case url = "url"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		artistName = try values.decodeIfPresent(String.self, forKey: .artistName)
		id = try values.decodeIfPresent(String.self, forKey: .id)
		releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		kind = try values.decodeIfPresent(String.self, forKey: .kind)
		copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
		artistId = try values.decodeIfPresent(String.self, forKey: .artistId)
		artistUrl = try values.decodeIfPresent(String.self, forKey: .artistUrl)
		artworkUrl100 = try values.decodeIfPresent(String.self, forKey: .artworkUrl100)
		genres = try values.decodeIfPresent([GamesGenres].self, forKey: .genres)
		url = try values.decodeIfPresent(String.self, forKey: .url)
	}

}
