# TravelDemo - 旅遊建議系統

一個使用 SwiftUI 開發的旅遊行程規劃應用程式，提供智能分析、行程試算、報告生成等功能。

## 專案簡介

TravelDemo 是一個展示現代 SwiftUI 開發模式的示範專案，採用 MVVM 架構和 Coordinator 模式，實現了完整的旅遊建議流程。

## 主要功能

- **智能分析**：根據使用者選擇的旅遊主題（城市、海島、自然、美食）提供個性化建議
- **規劃試算**：提供多種試算模式（熱門路線、慢步調、自訂行程）
- **報告輸出**：生成旅遊建議報告
- **完成確認**：完成流程確認頁面

## 專案架構

### 技術架構

- **MVVM 模式**：分離 View 和業務邏輯
- **Coordinator 模式**：統一管理導航流程
- **命名空間模式**：使用 `enum Travel {}` 作為命名空間，避免命名衝突

### 檔案結構

```
TravelDemo/
├── App/                          # App 入口
│   └── TravelDemoApp.swift
│
├── Core/                         # 核心基礎檔案
│   ├── Travel.swift              # 命名空間定義
│   ├── Travel+ViewModel.swift    # 主 ViewModel
│   ├── Travel+ContentView.swift  # 主視圖容器
│   ├── RootViewModel.swift       # 基礎 ViewModel
│   └── TravelSuggest+Coordinator.swift  # 導航協調器
│
├── Features/                     # 功能模組
│   ├── SmartAnalysis/           # 智能分析
│   ├── PlanSimulation/           # 規劃試算
│   ├── Report/                    # 報告輸出
│   └── Finish/                    # 完成頁
│
└── Assets.xcassets/              # 資源檔案
```

## 開發流程

### 流程步驟

1. **智能分析** (`.smartAnalysis`)
   - 使用者選擇旅遊主題
   - 系統記錄選擇的主題

2. **規劃試算** (`.planningCalculation`)
   - 選擇試算模式（熱門、慢步調、自訂）
   - 瀏覽推薦行程
   - 選擇心儀的行程

3. **報告生成** (`.createReport`)
   - 顯示選定的行程報告

4. **完成確認** (`.finished`)
   - 完成流程確認

## 設計模式

### 命名空間模式

使用空的 `enum` 作為命名空間：

```swift
enum Travel {}

extension Travel {
    struct ContentView: View { ... }
}
```

### Coordinator 模式

統一管理應用程式的導航流程：

```swift
extension TravelSuggest {
    final class Coordinator: ObservableObject {
        @Published var step: Step = .smartAnalysis
        @Published var selectedTheme: TravelThemeType?
        @Published var selectedPlan: Travel.Plan?
    }
}
```
## 授權

此專案為個人 Side Project，僅供學習和展示用途。

## 👤 作者

Created by kai

---



