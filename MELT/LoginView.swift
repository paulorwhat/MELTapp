//
//  LoginView.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import SwiftUI

struct LoginView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode

    @State private var username = ""
    @State private var password = ""  // Not used

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Username")) {
                    TextField("Enter username", text: $username)
                }
                Section(header: Text("Password")) {
                    SecureField("Enter password", text: $password)
                }
                Section {
                    Button("Log In") {
                        viewModel.login(username: username)
                        if viewModel.isLoggedIn {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .navigationBarTitle("Log In", displayMode: .inline)
        }
    }
}
