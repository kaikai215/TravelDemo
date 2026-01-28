//
//  RootViewModel.swift
//  TravelDemo
//
//  Created by kai on 2025/12/4.
//

import Foundation
import Combine

class RootViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    
    func showLoading(_ show: Bool) {
        isLoading = show
    }
}
