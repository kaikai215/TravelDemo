//
//  Travel+FinishedViewModel.swift
//  TravelDemo
//
//  Created by kai on 2025/12/4.
//

import Foundation

extension Travel {
    final class FinishedViewModel: RootViewModel {
        private(set) var coordinator: TravelSuggest.Coordinator?
        
        @MainActor
        func setup(coordinator: TravelSuggest.Coordinator) {
            self.coordinator = coordinator
        }
        
        @MainActor
        func backToHome() {
            coordinator?.selectedTheme = nil
            coordinator?.selectedPlan = nil
            coordinator?.update(step: .smartAnalysis)
        }
        
        func restart() {
            coordinator?.update(step: .smartAnalysis)
        }
    }
}
