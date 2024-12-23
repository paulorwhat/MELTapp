//
//  CreateAccountView.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import SwiftUI

struct CreateAccountView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @Environment(\.presentationMode) var presentationMode
    
    @State private var username = ""
    @State private var password = ""
    @State private var confirmPassword = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Username")) {
                    TextField("Enter username", text: $username)
                }
                Section(header: Text("Password")) {
                    SecureField("Enter password", text: $password)
                    SecureField("Confirm password", text: $confirmPassword)
                }
                Section {
                    Button("Create Account") {
                        // In a real app, you'd verify passwords match
                        viewModel.createAccount(username: username)
                        if viewModel.isLoggedIn {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .navigationBarTitle("Create Account", displayMode: .inline)
        }
    }
}
