//
//  CallApi.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 17/06/2024.
//

import Foundation

struct Constant {
    static let apiKey = "697d439ac993538da4e3e60b54e762cd"
    static let url = "https://api.themoviedb.org/"
}

enum APIError: Error{
    case faildToGetData
}

class CallApi{
    static let shared = CallApi()
    func getTrendingMovies(closure: @escaping(Result<[Movie] ,Error>) -> Void){
        
        let urlString = "\(Constant.url)3/trending/movie/day?api_key=\(Constant.apiKey)"
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
                let result =  try JSONDecoder().decode(TrendingMovies.self ,from: data)
                closure(.success(result.results))
            }catch{
                closure(.failure(error))
            }
        }
        task.resume()
    }
    
    func getTrendingTv(completion:@escaping (Result<[Tv],Error>) -> Void){
        let urlString = "\(Constant.url)3/trending/tv/day?api_key=\(Constant.apiKey)"
       
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
                let result = try JSONDecoder().decode(TrendingTv.self, from: data)
               print(result)
            }catch{
                print("Error: \(error)")
            }
        }
        task.resume()
    }
    
    func upComingMovies (completion: @escaping (Result<[Movie],Error>)->Void ){
        let urlString = "\(Constant.url)/3/movie/upcoming?api_key=\(Constant.apiKey)&language=en-US&page=1"
        guard let url = URL(string: urlString) else{
            print("Ivalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil ,let data = data else{
                print("Error: \(error!.localizedDescription)")
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingMovies.self, from: data)
                print(result)
            }catch{
                print("Errror: \(error)")
            }
        }
        task.resume()
    }
    
    func getPopular (completion: @escaping (Result<[Movie],Error>)->Void ){
        let urlString = "\(Constant.url)/3/movie/popular?api_key=\(Constant.apiKey)&language=en-US&page=1"
        guard let url = URL(string: urlString) else{
            print("Ivalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil ,let data = data else{
                print("Error: \(error!.localizedDescription)")
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingMovies.self, from: data)
                print(result)
            }catch{
                print("Errror: \(error)")
            }
        }
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Movie],Error>)->Void ){
        let urlString = "\(Constant.url)/3/movie/top_rated?api_key=\(Constant.apiKey)&language=en-US&page=1"
        guard let url = URL(string: urlString) else{
            print("Ivalid URL")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard error == nil ,let data = data else{
                print("Error: \(error!.localizedDescription)")
                return
            }
            do{
                let result = try JSONDecoder().decode(TrendingMovies.self, from: data)
                print(result)
            }catch{
                print("Errror: \(error)")
            }
        }
        task.resume()
    }
}
