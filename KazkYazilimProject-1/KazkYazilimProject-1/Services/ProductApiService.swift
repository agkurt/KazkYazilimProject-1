//
//  ProductApiService.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 20.03.2024.
//

import Foundation

class ProductApiService {
    
    var apiServiceProtocol: ApiServiceProtocol
    
    init(apiServiceProtocol: ApiServiceProtocol) {
        self.apiServiceProtocol = apiServiceProtocol
    }
    
}
