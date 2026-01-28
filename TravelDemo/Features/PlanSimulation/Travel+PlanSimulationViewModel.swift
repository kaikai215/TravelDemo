//
//  Travel+PlanSimulationViewModel.swift
//  TravelDemo
//
//  Created by kai on 2025/12/4.
//

import Foundation

extension Travel {
    final class PlanSimulationViewModel: RootViewModel {
        enum SelectionType {
            case popular  // 跟著大家玩
            case slow     // 慢步調深度遊
            case custom   // 自訂行程
        }
        
        @Published var selectionType: SelectionType = .popular
        @Published var plans: [Travel.Plan] = []
        @Published var selectedPlan: Travel.Plan?
        
        private(set) var coordinator: TravelSuggest.Coordinator?
        
        @MainActor
        func setup(coordinator: TravelSuggest.Coordinator) {
            guard self.coordinator == nil else { return }
            self.coordinator = coordinator
            refresh(type: .popular)
        }
        
        @MainActor
        func refresh(type: SelectionType) {
            selectionType = type
            loadPlans(for: type)
        }
        
        @MainActor
        private func loadPlans(for type: SelectionType) {
            // 根據選擇的類型和主題生成計劃
            guard let theme = coordinator?.selectedTheme else {
                plans = []
                return
            }
            
            switch type {
            case .popular:
                plans = generatePopularPlans(for: theme)
            case .slow:
                plans = generateSlowPacePlans(for: theme)
            case .custom:
                plans = generateCustomPlans(for: theme)
            }
        }
        
        private func generatePopularPlans(for theme: Travel.SmartAnalyticsSettingsViewModel.TravelThemeType) -> [Travel.Plan] {
            // 生成熱門路線計劃
            let cityName = theme.title
            return [
                Travel.Plan(
                    title: "經典 \(cityName) 三日遊",
                    days: 3,
                    city: cityName,
                    estimatedBudget: 15000,
                    highlights: [
                        "參觀最熱門的觀光景點",
                        "品嚐當地知名美食",
                        "體驗特色文化活動"
                    ]
                ),
                Travel.Plan(
                    title: "\(cityName) 深度五日遊",
                    days: 5,
                    city: cityName,
                    estimatedBudget: 25000,
                    highlights: [
                        "涵蓋所有必訪景點",
                        "多樣化行程安排",
                        "適合初次到訪的旅客"
                    ]
                )
            ]
        }
        
        private func generateSlowPacePlans(for theme: Travel.SmartAnalyticsSettingsViewModel.TravelThemeType) -> [Travel.Plan] {
            // 生成慢步調計劃
            let cityName = theme.title
            return [
                Travel.Plan(
                    title: "慢遊 \(cityName) 七日",
                    days: 7,
                    city: cityName,
                    estimatedBudget: 30000,
                    highlights: [
                        "深度體驗在地生活",
                        "少景點多時間的行程",
                        "適合喜歡慢慢探索的旅人"
                    ]
                )
            ]
        }
        
        private func generateCustomPlans(for theme: Travel.SmartAnalyticsSettingsViewModel.TravelThemeType) -> [Travel.Plan] {
            // 生成自訂計劃範例
            let cityName = theme.title
            return [
                Travel.Plan(
                    title: "自訂 \(cityName) 行程範例",
                    days: 4,
                    city: cityName,
                    estimatedBudget: 20000,
                    highlights: [
                        "可自行選擇景點",
                        "彈性安排時間",
                        "個人化旅遊體驗"
                    ]
                )
            ]
        }
        
        // Navigation
        @MainActor
        func backToSmartAnalysis() {
            coordinator?.update(step: .smartAnalysis)
        }
        
        @MainActor
        func gotoReport() {
            if let plan = selectedPlan {
                coordinator?.selectedPlan = plan
                coordinator?.update(step: .createReport)
            }
        }
    }
}

