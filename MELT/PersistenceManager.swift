//
//  PersistenceManager.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import Foundation

/// Handles reading/writing all MELT data to a JSON file (MELTData.json) in the app's Documents directory.
class PersistenceManager {
    static let shared = PersistenceManager()
    
    private let filename = "MELTData.json"
    
    /// A simple wrapper for all the app data. Must be Codable.
    struct MELTData: Codable {
        var users: [User]
    }
    
    /// The in-memory data, loaded when the app starts
    private(set) var meltData = MELTData(users: [])
    
    private init() {
        // Attempt to load from disk
        loadData()
    }
    
    /// Return the URL for the JSON file in Documents
    private func fileURL() -> URL? {
        do {
            let documents = try FileManager.default.url(for: .documentDirectory,
                                                        in: .userDomainMask,
                                                        appropriateFor: nil,
                                                        create: true)
            return documents.appendingPathComponent(filename)
        } catch {
            print("Error finding documents directory: \(error)")
            return nil
        }
    }
    
    /// Load the data from MELTData.json if it exists
    private func loadData() {
        guard let url = fileURL(), FileManager.default.fileExists(atPath: url.path) else {
            // No file yet
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoded = try JSONDecoder().decode(MELTData.self, from: data)
            self.meltData = decoded
        } catch {
            print("Failed to load MELTData from JSON: \(error)")
        }
    }
    
    /// Save the current in-memory data to MELTData.json
    func saveData() {
        guard let url = fileURL() else { return }
        
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(meltData)
            try data.write(to: url, options: .atomic)
        } catch {
            print("Failed to save MELTData to JSON: \(error)")
        }
    }
    
    // MARK: - CRUD Helpers
    
    /// Overwrite the entire array of users, then persist
    func setUsers(_ users: [User]) {
        meltData.users = users
        saveData()
    }
    
    /// Retrieve the entire array of users from memory
    func getUsers() -> [User] {
        meltData.users
    }
}
