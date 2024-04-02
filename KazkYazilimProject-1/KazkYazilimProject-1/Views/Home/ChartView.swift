//
//  ChartView.swift
//  KazkYazilimProject-1
//
//  Created by Ahmet Göktürk Kurt on 1.04.2024.
//

import SwiftUI
import Charts

struct ChartView: View {
    
    @State var selectTab = "Günlük"
    let data = [
        2.0 : UIColor.red,
        4.0 : UIColor.blue,
        5.0 : UIColor.purple,
        6.0 : UIColor.orange,
        7.0 : UIColor.green,
    ]
    
    var body: some View {
        NavigationStack {
            VStack(spacing:10) {
                Chart {
                    BarMark(x: .value("Day", "Jun 1"), y: .value("Value", 50))
                    BarMark(x: .value("Day", "Jun 2"), y: .value("Value", 30))
                        .foregroundStyle(.blue)
                    BarMark(x: .value("Day", "Jun 3"), y: .value("Value", 20))
                        .foregroundStyle(.teal)

                }
                Picker("Tabs", selection: $selectTab) {
                    Text("Günlük").tag("Günlük")
                    Text("3 Günlük").tag("3 Günlük")
                    Text("Haftalık").tag("Haftalık")
                    Text("Aylık").tag("Aylık")
                    Text("3 Aylık").tag("3 Aylık")
                    Text("Yıllık").tag("Yıllık")
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                switch selectTab {
                case "Günlük":
                    EmptyView()
                case "3 Günlük":
                    EmptyView()
                case "Haftalık":
                    EmptyView()
                case "Aylık":
                    EmptyView()
                case "3 Aylık":
                    EmptyView()
                case "Yıllık":
                    EmptyView()
                default :
                    EmptyView()
                }
            }
        }
    }
}

#Preview {
    ChartView()
}






