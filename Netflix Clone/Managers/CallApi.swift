//
//  CallApi.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 17/06/2024.
//

import Foundation

struct Constants {
    static let apiKey = "697d439ac993538da4e3e60b54e762cd"
    static let youtubeAPI = "AIzaSyAeO6IK48eH45D3cs1-7JgqCtnH2stPjP8"
    static let url = "https://api.themoviedb.org/"
    static let youtubeUrl = "https://youtube.googleapis.com"
}

enum APIError: Error{
    case faildToGetData
}

class CallApi{
    static let shared = CallApi()
    func getTrendingMovies(completion: @escaping(Result<[Titles] ,Error>) -> Void){
        
        let urlString = "\(Constants.url)3/trending/movie/day?api_key=\(Constants.apiKey)"
        guard let url = URL(string: urlString) else {
            print("Invalid Url")
            return
        }
        let task = URLSession.shared.dataTask(with: url) { Data, response, error in
            guard  error == nil ,let data = Data else {
                print("Error: \(error!.localizedDescription)")
                return
            }
            //            closure(data)
            
            do{
                let result =  try JSONDecoder().decode(TrendingTitles.self ,from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(APIError.faildToGetData))
            }
        }
        task.resume()
    }
    
    func getTrendingTv(completion: @escaping(Result<[Titles],Error>) -> Void){
        let urlString = "\(Constants.url)3/trending/tv/day?api_key=\(Constants.apiKey)"
        
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { Data, _, error in
            guard  error == nil ,let data = Data else{
                print("Error: \(error!.localizedDescription)")
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingTitles.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(APIError.faildToGetData))
            }
        }
        task.resume()
    }
    
    func upComingMovies (completion: @escaping (Result<[Titles],Error>)->Void ){
        let urlString = "\(Constants.url)/3/movie/upcoming?api_key=\(Constants.apiKey)&language=en-US&page=1"
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil ,let data = data else{
                print("Error: \(error!.localizedDescription)")
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingTitles.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(APIError.faildToGetData))
            }
        }
        task.resume()
    }
    
    func getPopular (completion: @escaping (Result<[Titles],Error>)->Void ){
        let urlString = "\(Constants.url)/3/movie/popular?api_key=\(Constants.apiKey)&language=en-US&page=1"
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil ,let data = data else{
                print("Error: \(error!.localizedDescription)")
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingTitles.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(APIError.faildToGetData))
            }
        }
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Titles],Error>)->Void ){
        let urlString = "\(Constants.url)/3/movie/top_rated?api_key=\(Constants.apiKey)&language=en-US&page=1"
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil ,let data = data else{
                print("Error: \(error!.localizedDescription)")
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingTitles.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(APIError.faildToGetData))
            }
        }
        task.resume()
    }
    
    func getDiscoverMovies(completion: @escaping (Result<[Titles],Error>)->Void ){
        let urlString = "\(Constants.url)/3/discover/movie?api_key=\(Constants.apiKey)&language=en-US&page=1"
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil ,let data = data else{
                print("Error: \(error!.localizedDescription)")
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingTitles.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(APIError.faildToGetData))
            }
        }
        task.resume()
    }
    
    
    func search(query: String ,completion: @escaping (Result<[Titles],Error>)->Void ){
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ,let url = URL(string: "\(Constants.url)/3/search/movie?api_key=\(Constants.apiKey)&query=\(query)") else{
            print("Invalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil ,let data = data else{
                print("Error: \(error!.localizedDescription)")
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingTitles.self, from: data)
                completion(.success(result.results))
            }catch{
                completion(.failure(APIError.faildToGetData))
            }
        }
        task.resume()
    }
    
    func getMovies(query: String ,completion: @escaping (Result<VideoElement ,Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.youtubeUrl)/youtube/v3/search?q=\(query)&key=\(Constants.youtubeAPI)") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { Data, _, error in
            guard  error == nil ,let data = Data else { return }
            
            do{
                let result = try JSONDecoder().decode(SearchListResponse.self, from: data)
                completion(.success(result.items[0]))
            }catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
