//
//  OrderView.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 29.03.2024.
//

import SwiftUI

struct OrderView: View {
    @EnvironmentObject var loginViewModel: LoginScreenViewModel
    @StateObject var orderViewModel = OrderViewModel(orderApiService: OrderApiService(apiServiceProtocol: URLSessionApiService.shared))
    @State private var isLoggedOut = false
    @State private var selectedTab = "Raporlar"
    @State private var searchText = ""
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
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
                .navigationBarItems(trailing: NavigationLink(destination: LoginScreenView(), isActive: $isLoggedOut) {
                    Button(action: {
                        loginViewModel.signOut()
                        isLoggedOut = true
                    }) {
                        Text("Çıkış Yap")
                    }
                })
                .alert(isPresented: $orderViewModel.showNoInternetAlert) {
                    Alert(title: Text("No Internet Connection"),
                          message: Text("Please check your internet connection and try again."),
                          dismissButton: .default(Text("OK"), action: {
                        isLoggedOut = true
                        showingAlert = true
                    }))
                }
                
            }
        }
    }
}








