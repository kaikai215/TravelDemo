//
//  Travel+SmartAnalyticsSettingView.swift
//  TravelDemo
//
//  Created by kai on 2025/12/4.
//

import SwiftUI

extension Travel {
    struct SmartAnalyticsSettingView: View {
        @StateObject private var viewModel = SmartAnalyticsSettingsViewModel()
        @EnvironmentObject private var coordinator: TravelSuggest.Coordinator
        
        var body: some View {
            VStack(alignment: .leading, spacing: 24) {
                Text("智能旅遊分析")
                    .font(.system(size: 22, weight: .bold))
                Text("選擇一個你現在最想要的旅遊風格，我們會幫你推薦對應的行程方向")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
                
                themeSelectionView()
                
                Spacer()
                
                HStack {
                    Spacer()
                    Button {
                        if let selected = viewModel.selectedTheme {
                            coordinator.selectedTheme = selected.type //把選到的主頁存進Coordinator
                            coordinator.update(step: .planningCalculation) //跳到規劃試算頁
                        }
                    } label: {
                        Text("下一步")
                            .font(.system(size: 16, weight: .medium))
                            .padding(.vertical, 10)
                            .padding(.horizontal, 20)
                            .foregroundStyle(.white)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(viewModel.selectedTheme == nil ? .gray : .blue)
                            )
                    }
                    .disabled(viewModel.selectedTheme == nil)
                }
            }
            .padding()
        }
        
        
        // MARK: - 主題選擇區塊
        @ViewBuilder
        private func themeSelectionView() -> some View {
            VStack(alignment: .leading, spacing: 16) {
                Text("選擇旅遊主題")
                    .font(.system(size: 18, weight: .bold))
                
                VStack(alignment: .leading, spacing: 16) {
                    ForEach(viewModel.themeItems) { item in
                        Button {
                            viewModel.select(item: item)
                        } label: {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(item.type.title)
                                    .font(.system(size: 16, weight: .bold))
                                Text(item.type.description)
                                    .font(.system(size: 12))
                                    .foregroundStyle(.gray)
                                    .lineLimit(2)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, minHeight: 80, alignment: .leading)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(item.isSelected ? .blue : .gray, lineWidth: item.isSelected ? 2 : 1 )
                            )
                        }
                    }
                }
            }
        }
    }

}

#Preview {
    Travel.SmartAnalyticsSettingView()
        .environmentObject(TravelSuggest.Coordinator())
}
