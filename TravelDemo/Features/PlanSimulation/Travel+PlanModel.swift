//
//  Travel+PlanModel.swift
//  TravelDemo
//
//  Created by kai on 2025/12/4.
//

import Foundation

extension Travel {
    struct Plan: Identifiable {
        let id = UUID()
        let title: String          // 行程名稱
        let days: Int              // 幾天幾夜
        let city: String           // 主要城市
        let estimatedBudget: Int   // 預估總預算（簡單用 Int）
        let highlights: [String]   // 行程亮點
        
        var formattedBudget: String {
            "\(estimatedBudget) 元起"
        }
        
        var daysDescription: String {
            "\(days) 天行程"
        }
    }
}
