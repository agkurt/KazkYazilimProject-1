//
//  OnboardingView.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 2.04.2024.
//

import SwiftUI

struct OnBoardingView: View {
    
    var onboardingUser: [OnboardingModel] = onboardingModel
    
    var body: some View {
      TabView {
        ForEach(onboardingUser[0...3]) { item in
            OnboardingScreensView(onboardingModel: item)
        }
      }
        
      .tabViewStyle(PageTabViewStyle())
      .padding(.vertical, 20)
    }

}

#Preview {
    OnBoardingView()
}

