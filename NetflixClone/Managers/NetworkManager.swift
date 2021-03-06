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
    private let baseURl = "https://api.themoviedb.org/3"
    private let youtubeAPIKey = "AIzaSyBd7L_scDPvuupJYPyhGrLpJR2XoylgsDY"
    private let youtubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
    
    func getTrendingMovies(completion: @escaping (Result<[Title], NFError>)-> Void) {
        guard let url = URL(string: "\(baseURl)/trending/movie/day?api_key=\(APIKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let results =  try decoder.decode(TrendingTitle.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(.failedToGetData))
            }
            
        }
        
        task.resume()
    }
    
    
    func getTrendingTVShow(completion: @escaping (Result<[Title], NFError>)-> Void) {
        guard let url = URL(string: "\(baseURl)/trending/tv/day?api_key=\(APIKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
           
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let results =  try decoder.decode(TrendingTitle.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(.failedToGetData))
            }
            
        }
        
        task.resume()

    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], NFError>)-> Void) {
        guard let url = URL(string: "\(baseURl)/movie/upcoming?api_key=\(APIKey)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let results = try decoder.decode(TrendingTitle.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(.failedToGetData))
            }

        }
        
        task.resume()
    }
    
    func getPopularMovies(completion: @escaping (Result<[Title], NFError>) -> Void) {
        guard let url = URL(string: "\(baseURl)/movie/popular?api_key=\(APIKey)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let results = try decoder.decode(TrendingTitle.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func getTopRatedMovies(completion: @escaping (Result<[Title], NFError>) -> Void) {
        guard let url = URL(string: "\(baseURl)/movie/top_rated?api_key=\(APIKey)&language=en-US&page=1") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let results = try decoder.decode(TrendingTitle.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(.failedToGetData))
            }
        }
        
        task.resume()
    }
        
    func getDiscoverMovies(completion: @escaping (Result<[Title], NFError>) -> Void) {
        guard let url = URL(string: "\(baseURl)/discover/movie?api_key=\(APIKey)&language=en-US&sort_by=popularity.desc&include_adult=true&include_video=false&page=1&with_watch_monetization_types=flatrate") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let results  = try decoder.decode(TrendingTitle.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(.failedToGetData))
            }

        }
        
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], NFError>) -> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        
        guard let url = URL(string: "\(baseURl)/search/movie?api_key=\(APIKey)&query=\(query)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let results  = try decoder.decode(TrendingTitle.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(.failedToGetData))
            }

        }
        
        task.resume()
    }
    
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, NFError>) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        guard let url = URL(string: "\(youtubeBaseURL)q=\(query)&key=\(youtubeAPIKey)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else { return }
            
            do {
                let decoder = JSONDecoder()
                let results = try decoder.decode(YoutubeSearchModel.self, from: data)
                completion(.success(results.items[0]))
            } catch {
                completion(.failure(.failedToGetData))
            }

        }
        
        task.resume()
    }
    
}
