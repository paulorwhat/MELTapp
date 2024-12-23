//
//  ProfileView.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                if let user = viewModel.currentUser {
                    Section(header: Text("User Info")) {
                        Text("Username: \(user.username)")
                    }
                    Section {
                        // Toggle Dark Mode
                        Toggle("Dark Mode", isOn: Binding(
                            get: { user.darkMode },
                            set: { _ in viewModel.toggleDarkMode() }
                        ))
                    }
                }
                Section {
                    Button("Log Out") {
                        viewModel.logout()
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.red)
                }
            }
            .navigationTitle("Profile")
            .navigationBarItems(trailing: Button("Close") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}
