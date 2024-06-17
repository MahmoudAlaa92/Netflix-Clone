//
//  CallApi.swift
//  Netflix Clone
//
//  Created by Mahmoud Alaa on 17/06/2024.
//

import Foundation

struct constant {
    static let apiKey = "697d439ac993538da4e3e60b54e762cd"
    static let url = "https://api.themoviedb.org/"
}

enum APIError: Error{
    case faildToGetData
}

class CallApi{
    static let shared = CallApi()
    func getTrendingMovies(closure: @escaping(Result<[Movie] ,Error>) -> Void){
        
        let urlString = "\(constant.url)3/trending/movie/day?api_key=\(constant.apiKey)"
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
}
