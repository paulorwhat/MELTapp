//
//  AddFolderView.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import SwiftUI

struct AddFolderView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var folderName = ""

    var onSave: (String) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Folder Name")) {
                    TextField("Enter folder name", text: $folderName)
                }
            }
            .navigationBarTitle("Add Folder", displayMode: .inline)
            .navigationBarItems(trailing: Button("Save") {
                if !folderName.isEmpty {
                    onSave(folderName)
                    presentationMode.wrappedValue.dismiss()
                }
            })
        }
    }
}
