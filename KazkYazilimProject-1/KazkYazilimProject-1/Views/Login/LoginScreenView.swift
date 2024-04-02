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
                    VStack {
                        VStack() {
                            VStack(alignment:.leading,spacing: 15) {
                                Text(" KAZK ECOMMERCE")
                                    .frame(maxWidth: .infinity,alignment:.leading)
                                    .font(.custom("Poppins-Medium", size: 25))
                                Text(" Login")
                                    .frame(maxWidth: .infinity,alignment:.leading)
                                    .font(.custom("Poppins-Bold", size: 25))
                            }
                            
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
                            }) {
                                if viewModel.isLoading {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                        .foregroundColor(.white)
                                        .padding(10)
                                        .background(Color(hex: "#313a45"))
                                        .cornerRadius(30)
                                        .frame(maxWidth: .infinity, alignment: .center)
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
                                Alert(title: Text("Login Failed"), message: Text("Please check your email and password and try again."), dismissButton: .default(Text("OK")))
                            }
                            .disabled(viewModel.isLoading) // Disable button when loading
                            
                            .background(
                                NavigationLink(destination: OrderView().navigationBarBackButtonHidden(true), isActive: $viewModel.isLogged) {
                                    EmptyView()
                                }
                                    .hidden()
                            )
                            .padding()
                        }
                        .navigationBarBackButtonHidden(true)
                        
                    }
                    .clipShape(.rect(cornerRadius:20))
                    .padding()
                    .padding(.top,25)
                
            }
            .ignoresSafeArea(.container)
            .onTapGesture {
                UIApplication.shared.hideKeyboard()
            }
        }
    }
}

