//
//  ContentView.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 29.03.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var loginScreenViewModel: LoginScreenViewModel
    
    var body: some View {
        VStack {
            if loginScreenViewModel.isLogged {
                OrderView()
            } else {
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
}






