//
//  Travel+ReportOutputView.swift
//  TravelDemo
//
//  Created by kai on 2025/12/4.
//

import SwiftUI

extension Travel {
    struct ReportOutputView: View {
        @StateObject private var viewModel = ReportOutputViewModel()
        @EnvironmentObject private var coordinator: TravelSuggest.Coordinator
        
        var body: some View {
            NavigationStack {
                VStack(alignment: .leading, spacing: 0) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24) {
                            headerView()
                            
                            if viewModel.hasValidData {
                                basicInfoSection()
                                Divider().padding(.vertical, 8)
                                highlightsSection()
                                Divider().padding(.vertical, 8)
                                noteSection()
                            } else {
                                Text("目前沒有完整的旅遊建議資料，請先回上一頁選擇行程。")
                                    .font(.system(size: 24))
                                    .foregroundStyle(.red)
                            }
                        }
                        .padding(.vertical, 24)
                    }
                    .scrollIndicators(.hidden)
                    
                    bottomButtons()
                }
                .padding(.horizontal, 16)
                .onAppear {
                    viewModel.setup(coordinator: coordinator)
                }
            }
        }
    }
}

// MARK: - 子 View

extension Travel.ReportOutputView {
    @ViewBuilder
    func headerView() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("旅遊建議報告")
                .font(.system(size: 22, weight: .bold))
                .foregroundStyle(.blue)
            
            Text("根據你的旅遊偏好與選擇的行程，以下是為你整理的旅遊建議摘要。")
                .font(.system(size: 14))
                .foregroundStyle(.gray)
        }
    }
    
    @ViewBuilder
    func basicInfoSection() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("ㄧ、基本資訊")
                .font(.system(size: 18, weight: .bold))
            
            VStack(alignment: .leading, spacing: 8) {
                infoRow(title: "旅遊主題", value: viewModel.themeTitle)
                infoRow(title: "推薦行程", value: viewModel.planTitle)
                infoRow(title: "主要地點", value: viewModel.city)
                infoRow(title: "天數", value: viewModel.daysDescription)
                infoRow(title: "預估總預算", value: viewModel.budgetDescription)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.05))
            )
        }
    }
    
    @ViewBuilder
    func infoRow(title: String, value: String) -> some View {
        HStack(alignment: .top) {
            Text(title)
                .font(.system(size: 14, weight: .bold))
                .frame(width: 80, alignment: .leading)
            Text(value)
                .font(.system(size: 14))
            Spacer()
        }
    }
    
    @ViewBuilder
    func highlightsSection() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("二、行程亮點")
                .font(.system(size: 18, weight: .bold))
            
            if viewModel.highlights.isEmpty {
                Text("此行程尚未設定亮點描述。")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(viewModel.highlights, id: \.self) { text in
                        HStack(alignment: .top, spacing: 6) {
                            Circle()
                                .frame(width: 4, height: 4)
                                .padding(6)
                            Text(text)
                                .font(.system(size: 14))
                        }
                    }
                }
                .padding(16)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.05))
                )
            }
        }
    }
    
    @ViewBuilder
    func noteSection() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("三、備註")
                .font(.system(size: 18, weight: .bold))

            Text("""
                1. 本旅遊建議報告僅作為參考建議，實際花費會依照匯率、訂位時間、旅遊淡旺季等因素有所不同。
                2. 建議提前確認機票與住宿價格，並預留彈性預算以應付臨時變動。
                3. 建議依照自身體力、飲食習慣與旅伴需求，適度調整每日行程安排。
                """)
            .font(.system(size: 14))
            .foregroundStyle(.gray)
            .lineSpacing(6)
        }
    }
    
    @ViewBuilder
    func bottomButtons() -> some View {
        VStack {
            Divider()

            HStack(spacing: 16) {
                Button {
                    viewModel.backToPlanning()
                } label: {
                    Text("返回調整行程")
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.gray.opacity(0.15))
                        )
                        .foregroundStyle(Color.blue)
                }

                Button {
                    viewModel.finish()
                } label: {
                    Text("完成")
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.blue)
                        )
                        .foregroundStyle(.white)
                }
            }
            .font(.system(size: 16, weight: .medium))
            .padding(.vertical, 12)
        }
    }
}



#Preview {
    NavigationStack {
        Travel.ReportOutputView()
            .environmentObject(TravelSuggest.Coordinator())
    }
}
