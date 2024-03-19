//
//  BackgroundView.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 20.03.2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Color(getColorBasedOnScheme())
        .edgesIgnoringSafeArea(.all)
        
    }

    @Environment(\.colorScheme) private var colorScheme

    private func getColorBasedOnScheme() -> Color {
        switch colorScheme {
        case .light:
            return Color.white
        case .dark:
            return Color.init(hex:"#272d36")
        default:
            return Color.init("#3c4654")
        }
    }
}
