//
//  URLSessionApiService.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 20.03.2024.
//

import Foundation

class URLSessionApiService {
    
    static let shared = URLSessionApiService()
    
    private init ()  { }
    
    func getRequest<T:Decodable>(endpoint:String,userLogin:UserLogin,completion: @escaping (Result<T,Error>) -> Void) {
        
        guard let url = URL(string: endpoint ) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            fatalError("")
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Data not found", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
                print(decodedData)
            }catch {
                completion(.failure(error))
            }
            
        }
        .resume()
    }
}
