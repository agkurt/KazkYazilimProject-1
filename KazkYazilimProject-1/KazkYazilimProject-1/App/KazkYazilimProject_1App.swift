//
//  KazkYazilimProject_1App.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 20.03.2024.
//

import SwiftUI

@main
struct KazkYazilimProject_1App: App {

    @StateObject var loginViewModel = LoginScreenViewModel(userLoginApiService: .init(apiServiceProtocol: URLSessionApiService.shared))
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(loginViewModel)
        }
    }
}
