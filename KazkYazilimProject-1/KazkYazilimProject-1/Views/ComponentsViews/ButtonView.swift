//
//  ButtonView.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 4.04.2024.
//

import SwiftUI

struct ButtonView: View {
    var action : () -> Void
    @StateObject private var viewModel = LoginScreenViewModel(userLoginApiService: UserLoginApiService(apiServiceProtocol: URLSessionApiService.shared))
    
    var body: some View {
        VStack {
            Button(action: action) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    Text("Login")
                        .font(.custom("Poppins-Light", size: 15))
                        .frame(maxWidth: .infinity,alignment:.center)
                        .padding()
                        .background(Color(hex: "#313a45"))
                        .foregroundColor(.white)
                        .cornerRadius(30)
                }
            }
            
        }
    }
}
