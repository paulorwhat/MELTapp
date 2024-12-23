//
//  LandingView.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import SwiftUI

struct LandingView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showingLogin = false
    @State private var showingCreate = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Simple "logo" with a military-themed system icon
                Image(systemName: "scope") // or "shield.lefthalf.filled", etc.
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .padding()
                    .foregroundColor(.primary)
                // For a “money + camera” vibe, you might do a custom image or a combined SF Symbol

                Text("MELT")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)

                Text("Military Expense Logging Tool")
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Spacer()

                // Buttons
                HStack {
                    Button("Log In") {
                        showingLogin = true
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("ArmyGreen"))
                    .foregroundColor(.white)
                    .cornerRadius(10)

                    Button("Create Account") {
                        showingCreate = true
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("ArmyGreen"))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .padding(.horizontal)

                Spacer()
            }
            // Make the background a subtle greenish tint
            .background(Color("ArmyGreen").opacity(0.1))
            .navigationBarHidden(true)
            .sheet(isPresented: $showingLogin) {
                LoginView()
            }
            .sheet(isPresented: $showingCreate) {
                CreateAccountView()
            }
        }
    }
}
