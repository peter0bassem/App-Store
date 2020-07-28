//
//  Service.swift
//  App Store
//
//  Created by Peter Bassem on 7/25/20.
//  Copyright © 2020 Peter Bassem. All rights reserved.
//

import Foundation

class Service {
    
    /// FOR STUDY PURPOSE ONLYYY
    //    func fetchApps(searchItem: String, completion: @escaping (Result<[Results]?, ServiceError>) -> Void) {
    //        let urlString = "https://itunes.apple.com/search?term=\(searchItem)&entity=software"
    //        guard let url = URL(string: urlString) else { return }
    //        URLSession.shared.dataTask(with: url) { (data, response, error) in
    //            if let error = error {
    //                completion(.failure(.failedToFetchData(error: error)))
    //                return
    //            }
    //            guard let data = data else { return }
    //            do {
    //                let searchResults = try JSONDecoder().decode(SearchResult.self, from: data)
    //                completion(.success(searchResults.results))
    //
    //            } catch let error {
    //                completion(.failure(.decodeError(error: error)))
    //            }
    //        }.resume()
    //    }
    ///////////////////////////////////////////////////////////////////////////////////
    
    static let shared = Service()
    
    private init() { }
    
    internal enum ServiceError: Error {
        case failedToFetchData(error: Error)
        case decodeError(error: Error)
    }
    
    func fetchApps(searchItem: String, completion: @escaping (_ appResults: SearchResult?, _ error: ServiceError?) -> Void) {
        let urlString = "https://itunes.apple.com/search?term=\(searchItem)&entity=software"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchTopGrossing(completion: @escaping (_ appGroup: AppGroup?, _ error: ServiceError?) -> Void) {
        let urlString = "https://rss.itunes.apple.com/api/v1/eg/ios-apps/top-grossing/all/25/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchGames(completion: @escaping (_ appGroup: AppGroup?, _ error: ServiceError?) -> Void) {
        fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/eg/ios-apps/new-games-we-love/all/50/explicit.json", completion: completion)
    }
    
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchTopFree(completion: @escaping (_ appGroup: AppGroup?, _ error: ServiceError?) -> Void) {
        fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/eg/ios-apps/top-free/all/25/explicit.json", completion: completion)
    }
    
    //helper
    private func fetchAppGroup(urlString: String, completion: @escaping (_ appGroup: AppGroup?, _ error: ServiceError?) -> Void) {
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    func fetchSocialApps(completion: @escaping (_ socialApps: [SocialApp]?, _ error: ServiceError?) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericJSONData(urlString: urlString, completion: completion)
    }
    
    
    func fetchGenericJSONData<T: Codable>(urlString: String, completion: @escaping (T?, ServiceError?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, ServiceError.failedToFetchData(error: error))
                return
            }
            guard let data = data else { return }
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                completion(objects, nil)
            } catch let error {
                completion(nil, ServiceError.decodeError(error: error))
            }
        }.resume()
    }
}
