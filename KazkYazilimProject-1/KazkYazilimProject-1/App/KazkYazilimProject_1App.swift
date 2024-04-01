//
//  KazkYazilimProject_1App.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 20.03.2024.
//

import SwiftUI

@main
struct KazkYazilimProject_1App: App {

    @StateObject var loginScreenViewModel = LoginScreenViewModel(userLoginApiService: .init(apiServiceProtocol: URLSessionApiService.shared))
    
    var body: some Scene {
        WindowGroup {
            ContentView(loginScreenViewModel: loginScreenViewModel)
                .environmentObject(loginScreenViewModel)
        }
    }
}
