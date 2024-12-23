//
//  AppViewModel.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import SwiftUI

/// Stores the global app state (list of users, the current user, etc.).
/// On init, loads from PersistenceManager; on changes, saves back.
class AppViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var currentUser: User?
    @Published var isLoggedIn = false
    
    init() {
        // Load from the JSON file
        self.users = PersistenceManager.shared.getUsers()
    }
    
    // MARK: - Auth
    
    /// Attempt to log in by matching username
    func login(username: String) {
        if let foundUser = users.first(where: { $0.username == username }) {
            currentUser = foundUser
            isLoggedIn = true
        } else {
            // No user found
            isLoggedIn = false
        }
    }
    
    /// Create a new user if username not taken
    func createAccount(username: String) {
        guard !users.contains(where: { $0.username == username }) else {
            isLoggedIn = false
            return
        }
        let newUser = User(username: username, darkMode: false, folders: [])
        users.append(newUser)
        PersistenceManager.shared.setUsers(users)
        
        currentUser = newUser
        isLoggedIn = true
    }
    
    /// Toggle dark mode
    func toggleDarkMode() {
        guard var user = currentUser else { return }
        user.darkMode.toggle()
        
        // Replace the user in our array
        if let index = users.firstIndex(where: { $0.id == user.id }) {
            users[index] = user
            PersistenceManager.shared.setUsers(users)
        }
        
        currentUser = user
        objectWillChange.send()
    }
    
    /// Log out
    func logout() {
        currentUser = nil
        isLoggedIn = false
    }
}
