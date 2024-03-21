//
//  ProductApiService.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 21.03.2024.
//

import Foundation

class ProductApiService {
    
    let apiServiceProtocol :ApiServiceProtocol
    
    init(apiServiceProtocol: ApiServiceProtocol) {
        self.apiServiceProtocol = apiServiceProtocol
    }
        
    func getAllProduct(parameters: [String:Any]?,completion: @escaping (Result<[Product],Error>)-> Void) {
        apiServiceProtocol.getRequest(parameters: parameters, endpoint: APIConstants.baseURL) { (result: Result<ProductResponse,Error>) in
            switch result {
            case .success(let data):
                completion(.success(data.products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
