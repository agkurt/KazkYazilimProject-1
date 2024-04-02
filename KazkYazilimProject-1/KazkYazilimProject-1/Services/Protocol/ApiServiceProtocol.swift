//
//  ApiServiceProtocol.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 20.03.2024.
//

import Foundation

protocol ApiServiceProtocol {
    func postTokenRequest<T: Codable>(endpoint: String, completion: @escaping(Result<T, Error>) -> Void) // GET
    func addRequest<T: Codable,U:Codable>(endpoint: String, data: T, completion: @escaping(Result<U, Error>) -> Void) // POST
    func updateRequest<T: Codable>(endpoint: URL, data: T, completion: @escaping(Result<Void, Error>) -> Void)
    func deleteRequest(endpoint: URL, completion: @escaping(Result<Void, Error>) -> Void)
}
 
