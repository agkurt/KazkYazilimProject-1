//
//  APIConstants.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 20.03.2024.
//

import Foundation

class APIConstants {
    
    static func loginURL(subdomain: String) -> String {
        return "http://service.\(subdomain).kazkerp.com/api/exec/login"
    }
    static func productURL(subdomain:String) -> String {
        return "http://service.\(subdomain).kazkerp.com/api/exec/get_orders"
    }
}

