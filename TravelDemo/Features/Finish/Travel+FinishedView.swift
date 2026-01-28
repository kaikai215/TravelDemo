//
//  Travel+FinishedView.swift
//  TravelDemo
//
//  Created by kai on 2025/12/4.
//

import SwiftUI

extension Travel {
    struct FinishedView: View {
        @StateObject private var viewModel = FinishedViewModel()
        @EnvironmentObject private var coordinator: TravelSuggest.Coordinator

        var body: some View {
            VStack(spacing: 32) {
                Spacer()

                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundStyle(.green)

                Text("旅遊建議已完成！")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundStyle(.blue)

                Text("你已成功完成旅遊規劃，歡迎回首頁或重新開始。")
                    .font(.system(size: 16))
                    .foregroundStyle(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 32)

                Spacer()

                VStack(spacing: 16) {
                    Button {
                        viewModel.backToHome()
                    } label: {
                        Text("回到智能分析")
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.15))
                            )
                            .foregroundStyle(.blue)
                    }

                    Button {
                        viewModel.restart()
                    } label: {
                        Text("重新開始")
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.blue)
                            )
                            .foregroundStyle(.white)
                    }
                }
                .padding(.horizontal, 24)

                Spacer()
            }
            .padding()
            .onAppear {
                viewModel.setup(coordinator: coordinator)
            }
        }
    }
}

#Preview {
    Travel.FinishedView()
        .environmentObject(TravelSuggest.Coordinator())
}
