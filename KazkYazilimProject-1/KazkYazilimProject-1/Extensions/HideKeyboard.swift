//
//  HideKeyboard.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 1.04.2024.
//

import SwiftUI

extension UIApplication {
    
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
}
