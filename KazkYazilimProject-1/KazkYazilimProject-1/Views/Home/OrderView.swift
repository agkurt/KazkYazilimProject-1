//
//  OrderView.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 29.03.2024.
//

import SwiftUI

struct OrderView: View {
    
    @EnvironmentObject var loginViewModel: LoginScreenViewModel
    @StateObject var orderViewModel = OrderViewModel(orderApiService: .init(apiServiceProtocol: URLSessionApiService.shared))
    @State private var isLoggedOut = false
    @State private var selectedTab = "Raporlar"
    @State private var searchText = ""
    
    var body: some View {
       
            ZStack {
                BackgroundView()
                VStack(alignment:.center) {
                    if orderViewModel.isLogged {
                        ProgressView()
                    } else {
                        if orderViewModel.isLoaded {
                            Picker("Tabs", selection: $selectedTab) {
                                Text("Raporlar").tag("Raporlar")
                                Text("Satışlar").tag("Satışlar")
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
                                .onTapGesture {
                                    UIApplication.shared.hideKeyboard()
                                }
                            } else {
                                ProgressView()
                            }
                            
                        case "Raporlar":
                            ChartView()
                        default:
                            EmptyView()
                        }
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
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            loginViewModel.signOut()
                            loginViewModel.userLogin.password = ""
                            loginViewModel.userLogin.email = ""
                        } label: {
                            Text("Çıkış Yap")
                        }

                    }
                }
            }
        
    }
}








