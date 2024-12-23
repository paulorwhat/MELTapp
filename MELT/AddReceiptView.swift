//
//  NewReceiptData.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import SwiftUI

struct NewReceiptData {
    var image: UIImage?
    var amount: Double
    var description: String
    var date: Date   // New field for the user-chosen date
}

struct AddReceiptView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var amountText = ""
    @State private var descriptionText = ""
    @State private var selectedImage: UIImage?
    @State private var selectedDate = Date()  // default to now

    @State private var showingPhotoDialog = false
    @State private var showingCamera = false
    @State private var showingPhotoLibrary = false

    var onAdd: (NewReceiptData) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Receipt Details")) {
                    TextField("Amount (£)", text: $amountText)
                        .keyboardType(.decimalPad)
                    
                    TextField("Description", text: $descriptionText)

                    // A date picker to manually set the date/time
                    DatePicker(
                        "Date",
                        selection: $selectedDate,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                }

                Section(header: Text("Photo")) {
                    // Display selected image or placeholder
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 200)
                    } else {
                        Text("No photo selected")
                            .foregroundColor(.gray)
                    }

                    // Single button that triggers a confirmation dialog
                    Button("Add Photo") {
                        showingPhotoDialog = true
                    }
                    .confirmationDialog("Choose Photo Source", isPresented: $showingPhotoDialog, actions: {
                        Button("Camera") { showingCamera = true }
                        Button("Photo Library") { showingPhotoLibrary = true }
                        Button("Remove Photo", role: .destructive) {
                            selectedImage = nil
                        }
                    }, message: {
                        Text("Select a source for your receipt photo")
                    })
                }
            }
            .navigationBarTitle("Add Receipt", displayMode: .inline)
            .navigationBarItems(trailing:
                Button("Save") {
                    guard let amountVal = Double(amountText) else { return }
                    let data = NewReceiptData(
                        image: selectedImage,
                        amount: amountVal,
                        description: descriptionText,
                        date: selectedDate
                    )
                    onAdd(data)
                    presentationMode.wrappedValue.dismiss()
                }
            )
            // Sheets for camera / library
            .sheet(isPresented: $showingCamera) {
                ImagePicker(sourceType: .camera, selectedImage: $selectedImage)
            }
            .sheet(isPresented: $showingPhotoLibrary) {
                ImagePicker(sourceType: .photoLibrary, selectedImage: $selectedImage)
            }
        }
    }
}
