//
//  Product.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 20.03.2024.
//

struct ProductResponse: Codable,Hashable {
    let products : [Product]
}

struct Product: Codable, Identifiable,Hashable {
    let id: Int?
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}

