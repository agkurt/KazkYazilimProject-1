//
//  OrderView.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 29.03.2024.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var loginViewModel : LoginScreenViewModel
    @StateObject var orderViewModel = OrderViewModel(orderApiService: OrderApiService(apiServiceProtocol: URLSessionApiService.shared))
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                VStack(alignment:.leading) {
                    if orderViewModel.isLoaded {
                        Text("₺\(orderViewModel.ordersResponse?.total ?? 0)")
                            .font(.largeTitle)
                            .padding()
                        ScrollView {
                            VStack(alignment:.center) {
                                ForEach(orderViewModel.ordersResponse?.data ?? [], id: \.self) { order in
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
                                                            Text("\(String(format: "%.2f", item.price))")
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
                    } else {
                        ProgressView()
                    }
                }
                .onAppear {
                    if !orderViewModel.isLoaded {
                        orderViewModel.fetchOrders(subdomain: "3dteknomarket")
                    }
                }
                .navigationTitle("Siparişler")
                .navigationBarTitleDisplayMode(.inline)
                
                .navigationBarItems(trailing: Button(action: {
                    loginViewModel.signOut()
                    
                }) {
                    Text("Çıkış Yap")
                })
            }
        }
    }
}

#Preview {
    OrderView()
}

