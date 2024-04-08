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
    @EnvironmentObject var viewModel: LoginScreenViewModel
    
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(spacing:0) {
                VStack(spacing:0) {
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
                    .alert(isPresented: $viewModel.isErrorAlert) {
                        Alert(
                            title: Text("Giriş Hatası"),
                            message: Text("Subdomain, mail ve şifre alanlarını kontrol et."),
                            dismissButton: .default(Text("OK"))
                        )
                    }
                    .padding()
                }
                .navigationBarBackButtonHidden(true)
                
            }
            .clipShape(.rect(cornerRadius:20))
            .padding()
            .padding(.top,25)
            
        }
        
        .onTapGesture {
            UIApplication.shared.hideKeyboard()
        }
    }
}


