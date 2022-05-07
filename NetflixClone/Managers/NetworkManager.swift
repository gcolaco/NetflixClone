//
//  NetworkManager.swift
//  NetflixClone
//
//  Created by Gustavo Colaço on 07/05/22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init(){}
    
    private let APIKey = "e0912b96eca1c325911471cdac4b7291"
    private let baseURl = "https://api.themoviedb.org/"
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], NFError>)-> Void) {
        guard let url = URL(string: "\(baseURl)/3/trending/movie/day?api_key=\(APIKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let results =  try decoder.decode(TrendingMovies.self, from: data)
                completion(.success(results.results))
                print(results)
            } catch {
                completion(.failure(.failedToGetData))
            }
            
        }
        
        task.resume()
    }
    
    
    func getTrendingTVShow(completion: @escaping (Result<[TVShow], NFError>)-> Void) {
        guard let url = URL(string: "\(baseURl)/3/trending/tv/day?api_key=\(APIKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let results =  try decoder.decode(TrendingTVShow.self, from: data)
                completion(.success(results.results))
                print(results)
            } catch {
                completion(.failure(.failedToGetData))
            }
            
        }
        
        task.resume()

    }
    
}
