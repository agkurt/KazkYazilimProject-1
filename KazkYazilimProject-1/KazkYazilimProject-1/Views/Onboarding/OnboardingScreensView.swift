//
//  OnboardingView.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 2.04.2024.
//

import SwiftUI

struct OnboardingScreensView: View {
    
    var onboardingModel : OnboardingModel
    
    @State private var isAnimating: Bool = false

    var body: some View {
         ZStack {
           VStack(spacing: 20) {
           
               Image(onboardingModel.image)
               .resizable()
               .padding()
               .scaledToFit()
               .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
               .scaleEffect(isAnimating ? 1.0 : 0.6)

             Text(onboardingModel.title)
               .foregroundColor(Color.white)
               .font(.largeTitle)
               .multilineTextAlignment(.center)
               .fontWeight(.heavy)
               .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
             
             Text(onboardingModel.headline)
               .foregroundColor(Color.white)
               .multilineTextAlignment(.center)
               .padding(.horizontal, 16)
               .frame(maxWidth: 480)
                         
             StartButtonView()
           }
           
         }
         .onAppear {    
           withAnimation(.easeOut(duration: 0.5)) {
             isAnimating = true
           }
         }
         .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
         .background(LinearGradient(gradient: Gradient(colors: onboardingModel.gradientColors), startPoint: .top, endPoint: .bottom))
         .cornerRadius(20)
         .padding(.horizontal, 20)
       }
}
#Preview {
    OnboardingScreensView(onboardingModel: .init(title: "", headline: "", image: "", gradientColors: [Color.init(hex:"#272d36")]))
}

