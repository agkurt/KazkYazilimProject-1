//
//  OrderView.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 20.03.2024.
//

import SwiftUI

struct OrderView: View {
    
    @StateObject var viewModel = OrderViewModel(productApiService: .init(apiServiceProtocol: URLSessionApiService.shared))
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                VStack {
                    ForEach (viewModel.products, id:\.self) { product in
                        Text(product.title)
                    }
                }
            }
            .navigationTitle("Order View")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            viewModel.fetchAllProduct()
        }
    }
}

#Preview {
    OrderView()
}
