//
//  TravelSuggest+Coordinator.swift
//  TravelDemo
//
//  Created by kai on 2025/12/4.
//

import Foundation
import SwiftUI

enum TravelSuggest{}

extension TravelSuggest {
    final class Coordinator: ObservableObject {
        enum Step {
            case smartAnalysis // 智能分析
            case planningCalculation // 規劃試算
            case createReport // 旅遊建議報告
            case finished //完成頁
        }
        
        @Published var step: Step = .smartAnalysis
        
        // 第一頁選到的主題
        @Published var selectedTheme: Travel.SmartAnalyticsSettingsViewModel.TravelThemeType?
        
        // 第二頁選到的行程（要給報告頁用）
        @Published var selectedPlan: Travel.Plan?
        
        
        func update(step: Step) {
            self.step = step
        }
    }
}

extension TravelSuggest.Coordinator.Step {
    /// 第幾步（從 1 開始）
    var index: Int {
        switch self {
        case .smartAnalysis:       return 1
        case .planningCalculation: return 2
        case .createReport:        return 3
        case .finished:            return 3   // 完成視為停在第 3 步
        }
    }

    /// 總共有幾步
    var total: Int {
        3
    }

    /// 顯示在進度條上的文字
    var title: String {
        switch self {
        case .smartAnalysis:       return "智能分析"
        case .planningCalculation: return "規劃試算"
        case .createReport:        return "旅遊建議報告"
        case .finished:            return "完成"
        }
    }
}
