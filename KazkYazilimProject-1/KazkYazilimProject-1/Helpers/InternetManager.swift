//
//  InternetManager.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 4.04.2024.
//

import Network

class InternetManager {
    
    static let shared = InternetManager()
    
    private let monitor = NWPathMonitor()
    
    private init() {
        monitor.pathUpdateHandler = { path in
        
            if path.status == .satisfied {
                print("İnternet bağlantısı var.")
            } else {
                print("İnternet bağlantısı yok.")
            }
        }
        
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
    
    func isInternetAvailable() -> Bool {
        return monitor.currentPath.status == .satisfied
    }
}
