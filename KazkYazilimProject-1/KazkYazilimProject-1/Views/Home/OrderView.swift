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
    
    @State private var selectedTab = "Satışlar"
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                VStack(alignment:.leading) {
                    if orderViewModel.isLoaded {
                        Picker("Tabs", selection: $selectedTab) {
                            Text("Satışlar").tag("Satışlar")
                            Text("Raporlar").tag("Raporlar")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .padding()
                        
                    }
                    switch selectedTab {
                    case "Satışlar":
                        if orderViewModel.isLoaded {
                            Text("₺\(orderViewModel.ordersResponse?.total ?? 0)")
                                .font(.largeTitle)
                                .padding()
                            ScrollView {
                                VStack(alignment:.center) {
                                    DetailOrderListView(orderViewModel: orderViewModel, searchText: $searchText)
                                }
                            }
                        } else {
                            ProgressView()
                        }
                    case "Raporlar":
                        RaporlarView()
                    default:
                        EmptyView()
                    }
                    
                }
                .onAppear {
                    if !orderViewModel.isLoaded {
                        orderViewModel.fetchOrders(subdomain: loginViewModel.subdomain)
                    }
                }
                .navigationTitle(selectedTab)
                .navigationBarTitleDisplayMode(.inline)
                .searchable(text: $searchText)
                
                .navigationBarItems(trailing: Button(action: {
                    loginViewModel.signOut()
                    
                }) {
                    Text("Çıkış Yap")
                })
            }
        }
    }
}

struct RaporlarView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Raporlar")
                Spacer()
            }
        }
    }
}



