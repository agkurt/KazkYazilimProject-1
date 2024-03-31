//
//  UserLogin.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 28.03.2024.
//

import Foundation

// MARK: - UserLogin

struct UserLogin: Codable {
    var email: String
    var password: String
}

struct UserLoginResponse: Codable {
    let _id: String
    let name: String
    let email: String
    let created_at: String
    let updated_at: String
    let id: Int
    let device_id: String
    let token: String
}


