//
//  Order.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 29.03.2024.
//
import Foundation

struct OrdersResponse: Codable,Hashable {
  let data: [Order]
  let total: Float
}

struct Order: Codable,Hashable {
  let order_number: String
  let customer: String
  let source: String
  let created_at: String
  let outsource_order_items: [OrderItem]
}

struct OrderItem: Codable,Hashable {
  let count: Float
  let price: Float
  let inventory: Inventory
}

struct Inventory: Codable,Hashable {
  let short_name: String
}

