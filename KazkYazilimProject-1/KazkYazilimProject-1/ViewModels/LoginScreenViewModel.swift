//
//  LoginScreenViewModel.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 20.03.2024.
//

import SwiftUI
import KeychainSwift

class LoginScreenViewModel:ObservableObject {
    
    @Published var subdomain: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLogged: Bool = false
    @Published var colorScheme: ColorScheme?
    @Published var emails: String = ""
    @Published var focusedField: FocusableField?
    @Published var userLoginResponse: UserLoginResponse?
    @Published var userLogin = UserLogin(email: "", password: "")
    @Published var keychain = KeychainSwift()
    
    let userLoginApiService: UserLoginApiService
    
    init(userLoginApiService: UserLoginApiService) {
        self.userLoginApiService = userLoginApiService
        
    }
    
    func addUserLogin(userLogin: UserLogin) {
        userLoginApiService.loginRequest(subdomain:subdomain,data: userLogin) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    URLSessionApiService.shared.token = data.token
                    self.keychain.set(data.token, forKey: "token")
                    self.userLoginResponse = data
                    self.isLogged = true
                }
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    func signOut() {
        keychain.delete("token")
        self.isLogged = false
        self.objectWillChange.send()
        
    }
    
    func focusNextField(focusField:FocusableField) {
        switch focusedField {
        case .subdomain:
            focusedField = .email
        case .email:
            focusedField = .password
        case .password:
            focusedField = .subdomain
        case .none:
            break
        }
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
