//
//  ContentView.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 20.03.2024.
//

import SwiftUI

struct LoginScreenView: View {
    
    @FocusState var focusedField:FocusableField?
    @Environment(\.colorScheme) private var colorScheme
    @StateObject var viewModel = LoginScreenViewModel(userLoginApiService: .init(apiServiceProtocol: URLSessionApiService.shared))
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                GeometryReader { geometry in
                    VStack {
                        VStack(spacing:0) {
                            VStack(alignment:.leading,spacing: 15) {
                                Text(" KAZK ECOMMERCE")
                                    .frame(maxWidth: .infinity,alignment:.leading)
                                    .font(.custom("Poppins-Medium", size: 25))
                                Text(" Login")
                                    .frame(maxWidth: .infinity,alignment:.leading)
                                    .font(.custom("Poppins-Bold", size: 25))
                            }
                            .padding(.bottom,30)
                            
                            Text("Sign in with email")
                                .font(.custom("Poppins-Light", size: 15))
                                .frame(maxWidth: .infinity,alignment:.leading)
                                .padding()
                            
                            VStack(spacing:20) {
                                TextFieldView(text: $viewModel.subdomain,placeholder: "Subdomain")
                                    .focused($focusedField,equals: .subdomain)
                                TextFieldView(text: $viewModel.userLogin.email, placeholder: "Email")
                                    .focused($focusedField, equals: .email)
                                    .keyboardType(.emailAddress)
                                SecureTextField(text: $viewModel.userLogin.password)
                                    .focused($focusedField, equals: .password)
                            }
                            .padding()
                            
                            Button(action: {
                                viewModel.addUserLogin(userLogin: viewModel.userLogin)
                                if viewModel.showAlert {
                                    viewModel.showAlert = true
                                }
                            }) {
                                if viewModel.isLoading {
                                    ProgressView()
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
                            .alert(isPresented: $viewModel.showAlert) {
                                Alert(title: Text("Hata"), message: Text("Lütfen tüm alanları doldurunuz."), dismissButton: .default(Text("Tamam")))
                            }
                            
                            
                            .background(
                                NavigationLink(destination: OrderView().navigationBarBackButtonHidden(true), isActive: $viewModel.isLogged) {
                                    EmptyView()
                                }
                                    .hidden() // Bu, NavigationLink'i gizler
                            )
                            .ignoresSafeArea(.keyboard)
                            .padding()
                        }
                        .navigationBarBackButtonHidden(true)
                    }
                    .clipShape(.rect(cornerRadius:20))
                    .padding()
                    .frame(minWidth: geometry.size.width * 1,minHeight: geometry.size.height * 1)
                    .padding(.top,25)
                }
            }
            .ignoresSafeArea(.container)
        }
    }
}

