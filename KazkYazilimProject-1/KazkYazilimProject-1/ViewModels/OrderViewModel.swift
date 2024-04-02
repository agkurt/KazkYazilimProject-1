//
//  OrderViewModel.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 29.03.2024.
//

import SwiftUI
import Network

class OrderViewModel: ObservableObject {
    
    @Published var ordersResponse: OrdersResponse?
    @Published var isLoaded = false
    @Published var isLogged = false
    @Published var showNoInternetAlert = false
    
    let orderApiService: OrderApiService
    
    init(orderApiService: OrderApiService) {
        self.orderApiService = orderApiService
    }
    
    func fetchOrders(subdomain: String) {
        isLogged = true
        let monitor = NWPathMonitor()
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.orderApiService.getOrderRequest(subdomain: subdomain) { result in
                    switch result {
                    case .success(let data):
                        DispatchQueue.main.async {
                            self.ordersResponse = data
                            self.isLoaded = true
                            self.isLogged = false
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    self.showNoInternetAlert = true
                }
            }
        }
        
        monitor.start(queue: queue)
    }
}


