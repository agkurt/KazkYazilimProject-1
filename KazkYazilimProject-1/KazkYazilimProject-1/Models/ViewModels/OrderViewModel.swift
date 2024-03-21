//
//  OrderViewModel.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 21.03.2024.
//

import SwiftUI

class OrderViewModel:ObservableObject {
    
    @Published var products : [Product] = []
    @Published var product: Product?

    var productApiService: ProductApiService
    
    init(productApiService: ProductApiService) {
        self.productApiService = productApiService
    }
    
    func fetchAllProduct(parameters: [String:Any]? = nil) {
        productApiService.getAllProduct(parameters: parameters) { result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async {
                    self.products = products
                    print(products)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
