//
//  ContentView.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 29.03.2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var loginScreenViewModel = LoginScreenViewModel(userLoginApiService: .init(apiServiceProtocol: URLSessionApiService.shared))
    @AppStorage("isOnboarding") var isOnboarding: Bool = true
    @StateObject var orderViewModel = OrderViewModel(orderApiService: .init(apiServiceProtocol: URLSessionApiService.shared))

    var body: some View {
        NavigationStack {
            VStack {
                if isOnboarding {
                    OnBoardingView()
                }else if loginScreenViewModel.isLogged {
                    OrderView(orderViewModel: orderViewModel)
                }else {
                    LoginScreenView()
                }
            }
            .onAppear(perform: {
                if let token = loginScreenViewModel.keychain.get("token"),
                   let email = loginScreenViewModel.keychain.get("email"),
                   let password = loginScreenViewModel.keychain.get("password") {
                    URLSessionApiService.shared.token = token
                    loginScreenViewModel.email = email
                    loginScreenViewModel.password = password
                    loginScreenViewModel.isLogged = true
                }
            })
        }
        .environmentObject(loginScreenViewModel)
    }
}






