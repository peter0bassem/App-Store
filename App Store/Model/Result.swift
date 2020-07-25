/* 
Copyright (c) 2020 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Result : Codable {
	let isGameCenterEnabled : Bool?
	let screenshotUrls : [String]?
	let ipadScreenshotUrls : [String]?
	let appletvScreenshotUrls : [String]?
	let artworkUrl60 : String?
	let artworkUrl512 : String?
	let artworkUrl100 : String?
	let artistViewUrl : String?
	let supportedDevices : [String]?
	let advisories : [String]?
	let kind : String?
	let features : [String]?
	let trackCensoredName : String?
	let languageCodesISO2A : [String]?
	let fileSizeBytes : String?
	let sellerUrl : String?
	let contentAdvisoryRating : String?
	let averageUserRatingForCurrentVersion : Double?
	let userRatingCountForCurrentVersion : Int?
	let averageUserRating : Double?
	let trackViewUrl : String?
	let trackContentRating : String?
	let trackName : String?
	let trackId : Int?
	let primaryGenreId : Int?
	let releaseDate : String?
	let genreIds : [String]?
	let formattedPrice : String?
	let primaryGenreName : String?
	let isVppDeviceBasedLicensingEnabled : Bool?
	let currentVersionReleaseDate : String?
	let releaseNotes : String?
	let sellerName : String?
	let minimumOsVersion : String?
	let currency : String?
	let version : String?
	let wrapperType : String?
	let artistId : Int?
	let artistName : String?
	let genres : [String]?
	let price : Int?
	let description : String?
	let bundleId : String?
	let userRatingCount : Int?

	enum CodingKeys: String, CodingKey {

		case isGameCenterEnabled = "isGameCenterEnabled"
		case screenshotUrls = "screenshotUrls"
		case ipadScreenshotUrls = "ipadScreenshotUrls"
		case appletvScreenshotUrls = "appletvScreenshotUrls"
		case artworkUrl60 = "artworkUrl60"
		case artworkUrl512 = "artworkUrl512"
		case artworkUrl100 = "artworkUrl100"
		case artistViewUrl = "artistViewUrl"
		case supportedDevices = "supportedDevices"
		case advisories = "advisories"
		case kind = "kind"
		case features = "features"
		case trackCensoredName = "trackCensoredName"
		case languageCodesISO2A = "languageCodesISO2A"
		case fileSizeBytes = "fileSizeBytes"
		case sellerUrl = "sellerUrl"
		case contentAdvisoryRating = "contentAdvisoryRating"
		case averageUserRatingForCurrentVersion = "averageUserRatingForCurrentVersion"
		case userRatingCountForCurrentVersion = "userRatingCountForCurrentVersion"
		case averageUserRating = "averageUserRating"
		case trackViewUrl = "trackViewUrl"
		case trackContentRating = "trackContentRating"
		case trackName = "trackName"
		case trackId = "trackId"
		case primaryGenreId = "primaryGenreId"
		case releaseDate = "releaseDate"
		case genreIds = "genreIds"
		case formattedPrice = "formattedPrice"
		case primaryGenreName = "primaryGenreName"
		case isVppDeviceBasedLicensingEnabled = "isVppDeviceBasedLicensingEnabled"
		case currentVersionReleaseDate = "currentVersionReleaseDate"
		case releaseNotes = "releaseNotes"
		case sellerName = "sellerName"
		case minimumOsVersion = "minimumOsVersion"
		case currency = "currency"
		case version = "version"
		case wrapperType = "wrapperType"
		case artistId = "artistId"
		case artistName = "artistName"
		case genres = "genres"
		case price = "price"
		case description = "description"
		case bundleId = "bundleId"
		case userRatingCount = "userRatingCount"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		isGameCenterEnabled = try values.decodeIfPresent(Bool.self, forKey: .isGameCenterEnabled)
		screenshotUrls = try values.decodeIfPresent([String].self, forKey: .screenshotUrls)
		ipadScreenshotUrls = try values.decodeIfPresent([String].self, forKey: .ipadScreenshotUrls)
		appletvScreenshotUrls = try values.decodeIfPresent([String].self, forKey: .appletvScreenshotUrls)
		artworkUrl60 = try values.decodeIfPresent(String.self, forKey: .artworkUrl60)
		artworkUrl512 = try values.decodeIfPresent(String.self, forKey: .artworkUrl512)
		artworkUrl100 = try values.decodeIfPresent(String.self, forKey: .artworkUrl100)
		artistViewUrl = try values.decodeIfPresent(String.self, forKey: .artistViewUrl)
		supportedDevices = try values.decodeIfPresent([String].self, forKey: .supportedDevices)
		advisories = try values.decodeIfPresent([String].self, forKey: .advisories)
		kind = try values.decodeIfPresent(String.self, forKey: .kind)
		features = try values.decodeIfPresent([String].self, forKey: .features)
		trackCensoredName = try values.decodeIfPresent(String.self, forKey: .trackCensoredName)
		languageCodesISO2A = try values.decodeIfPresent([String].self, forKey: .languageCodesISO2A)
		fileSizeBytes = try values.decodeIfPresent(String.self, forKey: .fileSizeBytes)
		sellerUrl = try values.decodeIfPresent(String.self, forKey: .sellerUrl)
		contentAdvisoryRating = try values.decodeIfPresent(String.self, forKey: .contentAdvisoryRating)
		averageUserRatingForCurrentVersion = try values.decodeIfPresent(Double.self, forKey: .averageUserRatingForCurrentVersion)
		userRatingCountForCurrentVersion = try values.decodeIfPresent(Int.self, forKey: .userRatingCountForCurrentVersion)
		averageUserRating = try values.decodeIfPresent(Double.self, forKey: .averageUserRating)
		trackViewUrl = try values.decodeIfPresent(String.self, forKey: .trackViewUrl)
		trackContentRating = try values.decodeIfPresent(String.self, forKey: .trackContentRating)
		trackName = try values.decodeIfPresent(String.self, forKey: .trackName)
		trackId = try values.decodeIfPresent(Int.self, forKey: .trackId)
		primaryGenreId = try values.decodeIfPresent(Int.self, forKey: .primaryGenreId)
		releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
		genreIds = try values.decodeIfPresent([String].self, forKey: .genreIds)
		formattedPrice = try values.decodeIfPresent(String.self, forKey: .formattedPrice)
		primaryGenreName = try values.decodeIfPresent(String.self, forKey: .primaryGenreName)
		isVppDeviceBasedLicensingEnabled = try values.decodeIfPresent(Bool.self, forKey: .isVppDeviceBasedLicensingEnabled)
		currentVersionReleaseDate = try values.decodeIfPresent(String.self, forKey: .currentVersionReleaseDate)
		releaseNotes = try values.decodeIfPresent(String.self, forKey: .releaseNotes)
		sellerName = try values.decodeIfPresent(String.self, forKey: .sellerName)
		minimumOsVersion = try values.decodeIfPresent(String.self, forKey: .minimumOsVersion)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		version = try values.decodeIfPresent(String.self, forKey: .version)
		wrapperType = try values.decodeIfPresent(String.self, forKey: .wrapperType)
		artistId = try values.decodeIfPresent(Int.self, forKey: .artistId)
		artistName = try values.decodeIfPresent(String.self, forKey: .artistName)
		genres = try values.decodeIfPresent([String].self, forKey: .genres)
		price = try values.decodeIfPresent(Int.self, forKey: .price)
		description = try values.decodeIfPresent(String.self, forKey: .description)
		bundleId = try values.decodeIfPresent(String.self, forKey: .bundleId)
		userRatingCount = try values.decodeIfPresent(Int.self, forKey: .userRatingCount)
	}

}
