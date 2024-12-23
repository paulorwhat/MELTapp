//
//  RootView.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import SwiftUI

struct RootView: View {
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        Group {
            if viewModel.isLoggedIn, viewModel.currentUser != nil {
                MainContentView()
            } else {
                LandingView()
            }
        }
    }
}
