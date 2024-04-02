//
//  DetailListView.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 1.04.2024.
//

import SwiftUI

struct DetailOrderListView: View {
    @ObservedObject var orderViewModel: OrderViewModel
    @Binding var searchText: String

    var body: some View {
        ForEach(orderViewModel.ordersResponse?.data.filter { order in
            searchText.isEmpty || order.customer.localizedCaseInsensitiveContains(searchText)
        } ?? [], id: \.self) { order in
            VStack(alignment: .leading) {
                VStack(spacing:15) {
                    HStack() {
                        Text("\(order.customer)")
                            .font(.title3)
                            .bold()
                        Spacer()
                        Text("#\(order.order_number)")
                            .font(.title3)
                            .bold()
                    }
                    HStack(spacing:10) {
                        Text("\(order.source)")
                        let index = order.created_at.index(order.created_at.startIndex, offsetBy: 10)
                        let dateSubstring = order.created_at[..<index]
                        let date = String(dateSubstring)
                        Spacer()
                        Text("\(date)")
                        let totalPrice = order.outsource_order_items.reduce(0) { $0 + $1.price * Float($1.count) }
                        Text("₺\(String(format: "%.2f", totalPrice))")
                            .foregroundStyle(.green)
                    }
                }
                
                DisclosureGroup(
                    content: {
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Envanter")
                                    .bold()
                                Spacer()
                                Text("Adet")
                                    .bold()
                                    .padding()
                                Text("Fiyat")
                                    .bold()
                            }
                            ForEach(order.outsource_order_items, id: \.self) { item in
                                HStack {
                                    Text("\(item.inventory.short_name)")
                                    Spacer()
                                    Text("\(Int(item.count))")
                                        .padding()
                                    Text("₺\(String(format: "%.2f", item.price))")
                                        .foregroundStyle(.green)
                                }
                            }
                        }
                    },
                    label: {
                        Text("Detaylar")
                    }
                )
            }
            .padding()
            Divider()
        }
    }
}

