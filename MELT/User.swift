//
//  User.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import Foundation

/// A user who can have multiple folders. Conforms to Codable so it can be saved to JSON.
struct User: Identifiable, Codable, Equatable {
    let id: UUID
    var username: String
    var darkMode: Bool
    var folders: [Folder]

    init(username: String, darkMode: Bool, folders: [Folder]) {
        self.id = UUID()
        self.username = username
        self.darkMode = darkMode
        self.folders = folders
    }
}
