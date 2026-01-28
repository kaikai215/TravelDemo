//
//  TravelDemoApp.swift
//  TravelDemo
//
//  Created by kai on 2025/12/4.
//

import SwiftUI

@main
struct TravelDemoApp: App {
    @StateObject private var coordinator = TravelSuggest.Coordinator()
    
    var body: some Scene {
        WindowGroup {
            Travel.ContentView()
                .environmentObject(coordinator)
        }
    }
}
