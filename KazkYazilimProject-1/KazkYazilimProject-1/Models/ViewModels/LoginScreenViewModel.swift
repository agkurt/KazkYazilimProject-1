//
//  LoginScreenViewModel.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 20.03.2024.
//

import SwiftUI

class LoginScreenViewModel:ObservableObject {
    
    @Published var subdomain:String = ""
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var isLogged = false
    @Published private var colorScheme:ColorScheme?
    @Published var emails :String = ""
    @Published private var focusedField: FocusableField?
    
    func focusNextField(focusField:FocusableField)  {
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
