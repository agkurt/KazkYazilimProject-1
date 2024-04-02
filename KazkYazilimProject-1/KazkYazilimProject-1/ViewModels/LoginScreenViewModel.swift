//
//  LoginScreenViewModel.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 20.03.2024.
//

import SwiftUI
import KeychainSwift

class LoginScreenViewModel:ObservableObject {
    
    @AppStorage("subdomain") var subdomain: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLogged: Bool = false
    @Published var colorScheme: ColorScheme?
    @Published var emails: String = ""
    @Published var userLoginResponse: UserLoginResponse?
    @Published var userLogin = UserLogin(email: "", password: "")
    @Published var keychain = KeychainSwift()
    @Published var isLoading = false
    @Published var showAlert = false
    
    let userLoginApiService: UserLoginApiService
    
    init(userLoginApiService: UserLoginApiService) {
        self.userLoginApiService = userLoginApiService
        
    }
    
    func addUserLogin(userLogin: UserLogin) {
        if subdomain.isEmpty || userLogin.email.isEmpty || userLogin.password.isEmpty  {
            showAlert = true
        } else {
            isLoading = true
            userLoginApiService.loginRequest(subdomain:subdomain,data: userLogin) { result in
                switch result {
                case .success(let data):
                    DispatchQueue.main.async {
                        URLSessionApiService.shared.token = data.token
                        self.keychain.set(data.token, forKey: "token")
                        self.keychain.set(self.email, forKey: "email")
                        self.keychain.set(self.password, forKey: "password")
                        self.userLoginResponse = data
                        self.isLogged = true
                        self.isLoading = false
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.showAlert = true
                        self.isLoading = false
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    func signOut() {
        keychain.delete("token")
        URLSessionApiService.shared.token = nil
        self.isLogged = false
        self.objectWillChange.send()
        
    }
    
    func getColorBasedOnScheme(colorScheme:ColorScheme) -> Color {
        switch colorScheme {
        case .light:
            return Color.black
        case .dark:
            return Color.white
        default:
            return Color.gray.opacity(0.7)
        }
    }
}
