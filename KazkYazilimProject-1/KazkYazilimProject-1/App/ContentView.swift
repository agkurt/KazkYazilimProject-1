//
//  ContentView.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 29.03.2024.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var loginViewModel: LoginScreenViewModel

    var body: some View {
        NavigationView {
            VStack {
                if loginViewModel.isLogged {
                    OrderView()
                } else {
                    LoginScreenView()
                }
            }
        }
    }
}





