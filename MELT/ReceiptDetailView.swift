//
//  ReceiptDetailView.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import SwiftUI

struct ReceiptDetailView: View {
    @EnvironmentObject var viewModel: AppViewModel
    let folder: Folder
    let receipt: Receipt
    
    // A closure we can call to delete this receipt from the folder
    let onDelete: () -> Void

    var body: some View {
        Form {
            Section(header: Text("Photo")) {
                if let data = receipt.imageData, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 200)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 200)
                        .foregroundColor(.gray)
                }
            }
            Section(header: Text("Details")) {
                Text("Amount: £\(receipt.amount, specifier: "%.2f")")
                Text("Description: \(receipt.description)")
                Text("Date: \(receipt.timestamp, formatter: dateFormatter)")
            }

            Section {
                Button(role: .destructive) {
                    // Calls back to FolderDetailView to remove the receipt
                    onDelete()
                } label: {
                    Text("Delete Receipt")
                }
            }
        }
        .navigationTitle("Receipt Detail")
    }
}

private let dateFormatter: DateFormatter = {
    let fmt = DateFormatter()
    fmt.dateStyle = .medium
    fmt.timeStyle = .short
    return fmt
}()
