//
//  LoginScreenViewModel.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 20.03.2024.
//

import SwiftUI

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
    
    let userLoginApiService: UserLoginApiService
    
    init(userLoginApiService: UserLoginApiService) {
        self.userLoginApiService = userLoginApiService
        
        if let token = UserDefaults.standard.string(forKey: "token") {
                URLSessionApiService.shared.token = token
                self.isLogged = true
            }
    }
    
    func addUserLogin(userLogin: UserLogin,domain:String) {
        userLoginApiService.loginRequest(subdomain:domain,data: userLogin) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    URLSessionApiService.shared.token = data.token
                    UserDefaults.standard.set(data.token, forKey: "token")
                    self.isLogged = true
                    print("burda\(domain)")
                    self.userLoginResponse = data
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
