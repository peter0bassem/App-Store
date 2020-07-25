//
//  Service.swift
//  App Store
//
//  Created by Peter Bassem on 7/25/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case failedToFetchData(error: Error)
    case decodeError(error: Error)
}

class Service {
    
    static let shared = Service()
    
    private init() { }
    
    func fetchApps(completion: @escaping (_ appResults: [Result]?, _ error: Error?) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Failed to fetch apps:", error)
                completion(nil, ServiceError.failedToFetchData(error: error))
                return
            }
            guard let data = data else { return }
            do {
                let searchResults = try JSONDecoder().decode(SearchResult.self, from: data)
                completion(searchResults.results, nil)
                
            } catch let error {
                print("Failed to decode search results:", error)
                completion(nil, ServiceError.decodeError(error: error))
            }
        }.resume()
    }
}
