//
//  Travel+PlanSimulationView.swift
//  TravelDemo
//
//  Created by kai on 2025/12/4.
//

import SwiftUI

extension Travel {
    struct PlanSimulationView: View {
        @StateObject private var viewModel = PlanSimulationViewModel()
        @EnvironmentObject private var coordinator: TravelSuggest.Coordinator
        
        var body: some View {
            NavigationStack {
                VStack(alignment: .leading, spacing: 0) {
                    ScrollView {
                        VStack(alignment: .leading, spacing: 24){
                            planInfoView()
                            Divider()
                            
                            selectionTypeView()
                            Divider()
                            
                            plansListView()
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

extension Travel.PlanSimulationView {
    // MARK: - 上方：基本資訊
    
    @ViewBuilder
    func planInfoView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("規劃試算")
                .font(.system(size: 20, weight: .bold))
                .foregroundStyle(.blue)
            
            HStack(spacing: 24) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("選擇旅遊主題")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.gray)
                    
                    Text(coordinator.selectedTheme?.title ?? "尚未選擇")
                        .font(.system(size: 18, weight:  .bold))
                }
                
                Spacer()
            }
        }
    }
    // MARK: - 選擇試算模式（跟著大家 / 慢步調 / 自訂）
    
    @ViewBuilder
    func selectionTypeView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("選擇試算模式")
                .font(.system(size: 20, weight: .bold))
            
            HStack(spacing: 12) {
                modeButton(
                    titel: "跟著大家玩",
                    isSelected: viewModel.selectionType == .popular
                ) {
                    viewModel.refresh(type: .popular)
                }
                
                modeButton(
                    titel: "慢步調深度遊",
                    isSelected: viewModel.selectionType == .slow
                ) {
                    viewModel.refresh(type: .slow)
                }
                
                modeButton(
                    titel: "自訂行程",
                    isSelected: viewModel.selectionType == .custom
                ) {
                    viewModel.refresh(type: .custom)
                }
            }
            
            if viewModel.selectionType == .popular {
                Text("依照熱門旅遊路線幫你快速建立建議行程。")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
            } else if viewModel.selectionType == .slow {
                Text("以少點、多時間的方式，安排慢步調深度旅行。")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
            } else {
                Text("之後可以在這裡自行選景點、調整每日行程。")
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
            }
        }
    }
    
    @ViewBuilder
    func modeButton(titel: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(titel)
                .font(.system(size: 14, weight: .bold))
                .frame(maxWidth: .infinity, maxHeight: 40)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isSelected ? Color.blue.opacity(0.1) : Color.gray.opacity(0.1))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(isSelected ? Color.blue : Color.gray.opacity(0.4), lineWidth: isSelected ? 2 : 1)
                )
        }
    }
    
    // MARK: - 推薦行程列表
    @ViewBuilder
    func plansListView() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(viewModel.selectionType == .custom ? "自訂行程（範例）" : "推薦行程")
                .font(.system(size: 20, weight:  .bold))
            
            if viewModel.plans.isEmpty {
                Text("目前沒有對應的行程，可以稍後再補上自訂行程功能。")
                    .font(.system(size: 14))
                    .foregroundStyle(.red)
            } else {
                ForEach(viewModel.plans) { plan in
                    planCard(plan: plan)
                }
            }
        }
    }
    
    func planCard(plan: Travel.Plan) -> some View {
        Button {
            viewModel.selectedPlan = plan
        }label: {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(plan.title)
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                        
                        Text("\(plan.city) · \(plan.daysDescription)")
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                    Text(plan.formattedBudget)
                        .font(.system(size: 14, weight: .bold))
                        .foregroundStyle(.blue)
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text("行程亮點")
                        .font(.system(size: 14, weight: .bold))
                    
                    ForEach(plan.highlights, id: \.self) { hightlight in
                        HStack(alignment: .top, spacing: 6) {
                            Circle()
                                .frame(width: 4, height: 4)
                            Text(hightlight)
                                .font(.system(size: 14))
                        }
                    }
                }
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.05))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(viewModel.selectedPlan?.id == plan.id ? Color.blue : Color.clear, lineWidth: 2)
            )
        }
    }
    
    //MARK: - 下方按鈕烈
    func bottomButtons() -> some View {
        VStack {
            Divider()
            
            HStack(spacing: 16) {
                Button {
                    viewModel.backToSmartAnalysis()
                }label: {
                    Text("上一步")
                        .frame(maxWidth: .infinity , minHeight: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.gray.opacity(0.15))
                        )
                        .foregroundStyle(Color.blue)
                }
                
                Button {
                    //接儲存建議
                }label: {
                    Text("儲存建議")
                        .frame(maxWidth: .infinity, minHeight: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.gray.opacity(0.15))
                        )
                        .foregroundStyle(Color.blue)
                }
                
                Button {
                    viewModel.gotoReport()
                } label: {
                    Text("下一步")
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
        Travel.PlanSimulationView()
            .environmentObject(TravelSuggest.Coordinator())
    }
}
