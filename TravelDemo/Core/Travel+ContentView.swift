//
//  Travel+ContentView.swift
//  TravelDemo
//
//  Created by kai on 2025/12/4.
//

import SwiftUI

extension Travel {
    struct ContentView: View {
        @StateObject private var viewModel = Travel.ViewModel()
        @EnvironmentObject private var coordinator: TravelSuggest.Coordinator
        
        var body: some View {
            NavigationStack {
                VStack {
                    //進度條
                    TravelSuggest.FlowProgressView(step: coordinator.step)
                    
                    switch coordinator.step {
                    case .smartAnalysis:
                        Travel.SmartAnalyticsSettingView()
                    case .planningCalculation:
                        Travel.PlanSimulationView() 
                    case .createReport:
                        Travel.ReportOutputView()
                    case .finished:
                        Travel.FinishedView()
                    }
                }
                .padding()
            }
            .animation(.easeInOut, value: coordinator.step)
        }
    }
}

#Preview {
    Travel.ContentView()
        .environmentObject(TravelSuggest.Coordinator())
}
