//
//  FolderDetailView.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import SwiftUI

struct FolderDetailView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State var folder: Folder
    @State private var showingAddReceipt = false

    var body: some View {
        VStack {
            Text("Total: £\(folder.total, specifier: "%.2f")")
                .font(.headline)
                .padding()

            List {
                ForEach(folder.receipts) { receipt in
                    NavigationLink(destination: 
                        ReceiptDetailView(
                            folder: folder, 
                            receipt: receipt,
                            onDelete: { deleteReceiptById(receipt.id) }
                        )) {
                        ReceiptRowView(receipt: receipt)
                    }
                }
                .onDelete(perform: deleteReceipt)
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle(folder.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddReceipt = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.primary)
                }
            }
        }
        .sheet(isPresented: $showingAddReceipt) {
            AddReceiptView { newReceiptData in
                addReceipt(newReceiptData)
            }
        }
    }

    private func addReceipt(_ data: NewReceiptData) {
        let newReceipt = Receipt(
            amount: data.amount,
            description: data.description,
            timestamp: data.date, // now we store data.date, see below
            imageData: data.image?.pngData()
        )
        folder.receipts.append(newReceipt)
        saveFolder()
    }

    private func deleteReceipt(_ offsets: IndexSet) {
        folder.receipts.remove(atOffsets: offsets)
        saveFolder()
    }

    private func deleteReceiptById(_ receiptId: UUID) {
        folder.receipts.removeAll { $0.id == receiptId }
        saveFolder()
    }

    private func saveFolder() {
        guard var user = viewModel.currentUser else { return }
        if let folderIdx = user.folders.firstIndex(where: { $0.id == folder.id }) {
            user.folders[folderIdx] = folder
            if let userIdx = viewModel.users.firstIndex(where: { $0.id == user.id }) {
                viewModel.users[userIdx] = user
                viewModel.currentUser = user
                PersistenceManager.shared.setUsers(viewModel.users)
            }
        }
    }
}
