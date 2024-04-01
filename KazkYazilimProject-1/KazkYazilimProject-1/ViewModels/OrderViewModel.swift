//
//  OrderViewModel.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 29.03.2024.
//

import SwiftUI

class OrderViewModel: ObservableObject {
    
    @Published var ordersResponse: OrdersResponse?
    @Published var isLoaded = false
    
    let orderApiService: OrderApiService
    
    init(orderApiService: OrderApiService) {
        self.orderApiService = orderApiService
    }
    
    func fetchOrders(subdomain: String) {
        orderApiService.getOrderRequest(subdomain: subdomain) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.ordersResponse = data
                    self.isLoaded = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


