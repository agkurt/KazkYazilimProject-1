//
//  ProductApiService.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 21.03.2024.
//

import Foundation

class UserLoginApiService {
    
    let apiServiceProtocol :ApiServiceProtocol
    
    init(apiServiceProtocol: ApiServiceProtocol) {
        self.apiServiceProtocol = apiServiceProtocol
    }
    
    func loginRequest(subdomain:String,data: UserLogin, completion: @escaping (Result<UserLoginResponse, Error>) -> Void) {
        apiServiceProtocol.addRequest(endpoint: APIConstants.loginURL(subdomain: subdomain), data: data) { (result: Result<UserLoginResponse,Error>) in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
