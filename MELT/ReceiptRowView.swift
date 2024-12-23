//
//  ReceiptRowView.swift
//  MELT
//
//  Created by Paul O'Connor on 23/12/2024.
//


import SwiftUI

struct ReceiptRowView: View {
    let receipt: Receipt

    var body: some View {
        HStack(spacing: 15) {
            if let data = receipt.imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
            }
            VStack(alignment: .leading, spacing: 5) {
                Text("£\(receipt.amount, specifier: "%.2f")")
                    .font(.headline)
                    .foregroundColor(.primary)

                Text(receipt.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)

                Text("\(receipt.timestamp, formatter: dateFormatter)")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.vertical, 4)
        // Maybe give a slight greenish background or border
        //.background(Color("ArmyGreen").opacity(0.05))
        //.cornerRadius(8)
    }
}

private let dateFormatter: DateFormatter = {
    let fmt = DateFormatter()
    fmt.dateStyle = .medium
    fmt.timeStyle = .short
    return fmt
}()
