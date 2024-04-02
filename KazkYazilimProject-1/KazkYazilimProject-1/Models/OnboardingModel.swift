//
//  OnboardingModel.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 1.04.2024.
//

import Foundation
import SwiftUI

struct OnboardingModel:Identifiable {
    
    var id = UUID()
    var title: String
    var headline: String
    var image: String
    var gradientColors: [Color]
}

let onboardingModel: [OnboardingModel] = [
    OnboardingModel(title: "Boss Ecommerce uygulamasına hoşgeldiniz", headline: "İşinizin Lideri Olmaya Hazır mısınız? Boss Ecommerce ile Yola Çıkın ve Başarıya Doğru İlerleyin!", image: "ecommerceHome", gradientColors: [Color.init(hex:"#272d36")]),
    OnboardingModel(title: "Boss Ecommerce ile Satışlarınızı Kontrol Altına Alın", headline: "İşinizin Kontrolünü Elinizde Tutun: Satışlarınızı ve Müşterilerinizi Kolaylıkla İzleyin", image: "boss", gradientColors: [Color.init(hex:"#272d36")]),
    OnboardingModel(title: "Müşteri Analitiğiyle Müşteri Bağlılığını Artırın", headline: "Müşteri Analitiği Gücüyle Sadakati Artırın: Müşterilerinizin İhtiyaçlarını Tanıyın ve Daha İyi Hizmet Verin", image: "data", gradientColors: [Color.init(hex:"#272d36")]),
    OnboardingModel(title: "Verilerle Stratejik Kararlar Alın", headline: "Verilere Dayalı Stratejik Yönetim: İstatistiklerle Desteklenen Satış Planları Oluşturun ve İşinizi Büyütün", image: "statistics", gradientColors: [Color.init(hex:"#272d36")]),
    
]

