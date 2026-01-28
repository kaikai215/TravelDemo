//
//  Travel+ReportOutputViewModel.swift
//  TravelDemo
//
//  Created by kai on 2025/12/4.
//

import Foundation

extension Travel {
    final class ReportOutputViewModel: RootViewModel {
        @Published var themeTitle: String = "-"
        @Published var planTitle: String = "-"
        @Published var city: String = "-"
        @Published var daysDescription: String = "-"
        @Published var budgetDescription: String = "-"
        @Published var highlights: [String] = []
        
        private(set) var coordinator: TravelSuggest.Coordinator?
        
        //給畫面顯示（資料不足）的提示
        @Published var hasValidData: Bool = true

        
        @MainActor
        func setup(coordinator: TravelSuggest.Coordinator) {
            guard self.coordinator == nil else { return }
            self.coordinator = coordinator
            applyFromCoordinator()
        }
        
        @MainActor
        func  applyFromCoordinator() {
            guard let theme = coordinator?.selectedTheme,
                  let plan = coordinator?.selectedPlan else {
                hasValidData = false
                return
            }
            
            hasValidData = true
            
            themeTitle = theme.title
            planTitle = plan.title
            city = plan.city
            daysDescription = plan.daysDescription
            budgetDescription = plan.formattedBudget
            highlights = plan.highlights
        }
        
        //Navigation
        @MainActor
        func backToPlanning() {
            coordinator?.update(step: .planningCalculation)
        }
        
        @MainActor
        func finish() {
            coordinator?.update(step: .finished)
        }
    }
}
