//
//  MELTApp.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import SwiftUI

@main
struct MELTApp: App {
    @StateObject private var viewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(viewModel)
                // If the user is logged in, we check their darkMode setting
                .preferredColorScheme(viewModel.currentUser?.darkMode == true ? .dark : .light)
                // Give the whole app a green accent (replace with your favourite military colour)
                .accentColor(Color("ArmyGreen")) 
                // Note: You must define "ArmyGreen" in Assets.xcassets 
                // OR use a custom Color(red:...,green:...,blue:...)
        }
    }
}
