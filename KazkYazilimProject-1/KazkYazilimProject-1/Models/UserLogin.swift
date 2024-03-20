//
//  Users.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 20.03.2024.
//

import Foundation

struct UserLogin:Codable,Hashable {
    
    var subdomain:String
    var email:String
    var password:String
}
