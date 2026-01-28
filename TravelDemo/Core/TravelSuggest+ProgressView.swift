//
//  TravelSuggest+ProgressView.swift
//  TravelDemo
//
//  Created by kai on 2025/12/5.
//

import SwiftUI

extension TravelSuggest {
    struct FlowProgressView: View {
        let step: Coordinator.Step

        var body: some View {
            VStack(alignment: .leading, spacing: 8) {
                // 上面是條狀進度條
                ProgressView(
                    value: Double(step.index),
                    total: Double(step.total)
                )
                .tint(.blue)

                // 顯示：目前步驟名稱 ＋ 數字
                HStack {
                    Text(step.title)
                        .font(.system(size: 14, weight: .medium))

                    Spacer()

                    Text("\(step.index) / \(step.total)")
                        .font(.system(size: 12, weight: .regular))
                        .foregroundStyle(.gray)
                }
            }
            .padding(.vertical, 8)
        }
    }
}
