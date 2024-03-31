//
//  ProductApiService.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 29.03.2024.
//

import Foundation

class OrderApiService {
    
    let apiServiceProtocol : ApiServiceProtocol
    
    init(apiServiceProtocol: ApiServiceProtocol) {
        self.apiServiceProtocol = apiServiceProtocol
    }
    
    func getOrderRequest(subdomain:String,completion : @escaping (Result<OrdersResponse,Error>) -> Void) {
        apiServiceProtocol.postRequest(endpoint: APIConstants.productURL(subdomain: subdomain)) { (result:Result<OrdersResponse,Error>) in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
