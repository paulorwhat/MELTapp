//
//  Folder.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import Foundation

/// A folder containing multiple receipts. Codable for JSON persistence.
struct Folder: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var receipts: [Receipt]

    init(name: String, receipts: [Receipt]) {
        self.id = UUID()
        self.name = name
        self.receipts = receipts
    }
}

// calculate the total of all receipts in this folder
extension Folder {
    var total: Double {
        receipts.reduce(0) { $0 + $1.amount }
    }
}
