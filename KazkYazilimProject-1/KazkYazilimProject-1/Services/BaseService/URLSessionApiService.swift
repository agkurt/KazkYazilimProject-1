//
//  URLSessionApiService.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 20.03.2024.
//

import Foundation

class URLSessionApiService: ApiServiceProtocol {
    
    static let shared = URLSessionApiService()
    
    var token: String?
    
    private init ()  { }
    
    func postRequest<T:Decodable>(endpoint: String, completion: @escaping (Result<T, Error>) -> Void) {
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
            fatalError("")
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("\(token ?? "")", forHTTPHeaderField: "token")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
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
                print(error)
                completion(.failure(error))
            }
        }
        .resume()
    }
    
    func addRequest<T:Codable,U:Codable>(endpoint: String, data: T, completion: @escaping (Result<U, Error>) -> Void) {
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(NSError(domain: "not available url", code: 404, userInfo: nil)))
            return
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonData = try? JSONEncoder().encode(data) // converted to json
        urlRequest.httpBody = jsonData // headers
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "Data not found", code: 0, userInfo: nil)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(U.self, from: data)
                completion(.success(decodedData))
                print(decodedData)
            }catch {
                print(error)
                completion(.failure(error))
            }
        }
            .resume()
    }
    
    func updateRequest<T>(endpoint: URL, data: T, completion: @escaping (Result<Void, Error>) -> Void) where T : Decodable, T : Encodable {
        
    }
    
    func deleteRequest(endpoint: URL, completion: @escaping (Result<Void, Error>) -> Void) {
        
    }
}
