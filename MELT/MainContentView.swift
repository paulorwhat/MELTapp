//
//  MainContentView.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import SwiftUI

struct MainContentView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showingProfile = false

    var body: some View {
        NavigationView {
            FolderListView()
                .navigationTitle("Folders")
                .navigationBarItems(trailing: Button {
                    showingProfile = true
                } label: {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                })
                .sheet(isPresented: $showingProfile) {
                    ProfileView()
                }
        }
    }
}
