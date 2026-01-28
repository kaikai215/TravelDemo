//
//  Travel+SmartAnalyticsSettingsViewModel.swift
//  TravelDemo
//
//  Created by kai on 2025/12/4.
//

import Foundation

extension Travel {
    // Mark:- 智能分析 ViewModel
    final class SmartAnalyticsSettingsViewModel: RootViewModel {
        //旅遊主題類型
        enum TravelThemeType: String, CaseIterable, Codable {
            case city = "CITY"
            case island = "ISLAND"
            case nature = "NATURE"
            case food = "FOOD"
            
            var title: String {
                switch self {
                case .city:   return "城市漫步"
                case .island: return "海島放空"
                case .nature: return "自然健行"
                case .food:   return "美食小旅行"
                }
            }
            
            var description : String {
                switch self {
                case .city:
                    return "喜歡逛街、咖啡廳、博物館，步調較輕鬆。"
                case .island:
                    return "想要海邊、飯店、泳池、放空充電。"
                case .nature:
                    return "喜歡山林、步道、大自然風景。"
                case .food:
                    return "以美食為主，安排在地必吃餐廳與市場。"
                }
            }
        }
        
        struct TravelThemeItem: Identifiable, Equatable {
            let id = UUID()
            let type: TravelThemeType
            var isSelected: Bool = false
        }
        
        @Published var themeItems: [TravelThemeItem]
        @Published var selectedTheme: TravelThemeItem?
        
        override init() {
            self.themeItems = TravelThemeType.allCases.map {
                TravelThemeItem(type: $0)
            }
            super.init()
        }
        
        func select(item: TravelThemeItem) {
            selectedTheme = item
            
            var nweItems: [TravelThemeItem] = []
            for var theme in themeItems {
                theme.isSelected = (theme.type == item.type)
                nweItems.append(theme)
            }
            themeItems = nweItems
        }
    }
}
