//
//  FolderListView.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import SwiftUI

struct FolderListView: View {
    @EnvironmentObject var viewModel: AppViewModel
    @State private var showingAddFolder = false

    var body: some View {
        VStack {
            if let user = viewModel.currentUser {
                List {
                    ForEach(user.folders) { folder in
                        NavigationLink(destination: FolderDetailView(folder: folder)) {
                            HStack {
                                Image(systemName: "folder.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(.blue)
                                Text(folder.name)
                                    .font(.headline)
                            }
                        }
                    }
                    .onDelete(perform: deleteFolder)
                }
                .listStyle(InsetGroupedListStyle())
            } else {
                Text("No user is logged in.")
            }

            Button {
                showingAddFolder = true
            } label: {
                Text("Add Folder")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .shadow(radius: 5)
            }
            .padding()
            .sheet(isPresented: $showingAddFolder) {
                AddFolderView { folderName in
                    addFolder(named: folderName)
                }
            }
        }
    }

    private func addFolder(named name: String) {
        guard var user = viewModel.currentUser else { return }
        let newFolder = Folder(name: name, receipts: [])
        user.folders.append(newFolder)
        updateUser(user)
    }

    private func deleteFolder(at offsets: IndexSet) {
        guard var user = viewModel.currentUser else { return }
        user.folders.remove(atOffsets: offsets)
        updateUser(user)
    }

    private func updateUser(_ user: User) {
        // Replace user in the main array
        if let idx = viewModel.users.firstIndex(where: { $0.id == user.id }) {
            viewModel.users[idx] = user
            viewModel.currentUser = user
            // Save to JSON
            PersistenceManager.shared.setUsers(viewModel.users)
        }
    }
}
