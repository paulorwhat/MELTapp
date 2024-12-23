//
//  Receipt.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import Foundation

/// Represents an expense receipt. Stores image as optional Data for JSON encoding.
struct Receipt: Identifiable, Codable, Equatable {
    let id: UUID
    var amount: Double
    var description: String
    var timestamp: Date
    var imageData: Data?

    init(amount: Double, description: String, timestamp: Date, imageData: Data?) {
        self.id = UUID()
        self.amount = amount
        self.description = description
        self.timestamp = timestamp
        self.imageData = imageData
    }
}
