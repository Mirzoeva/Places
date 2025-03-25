//
//  CustomLocationView.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import SwiftUI

struct CustomLocationView: View {
    @StateObject private var viewModel = CustomLocationViewModel()

    var body: some View {
        Form {
            Section(header: Text("Enter Coordinates")) {
                TextField("Latitude", text: $viewModel.latitudeText)
                    .keyboardType(.decimalPad)
                    .accessibilityLabel("Latitude")
                TextField("Longitude", text: $viewModel.longitudeText)
                    .keyboardType(.decimalPad)
                    .accessibilityLabel("Longitude")
            }

            Section {
                Button("Open in Wikipedia") {
                    viewModel.openWikipediaIfValid()
                }
                .accessibilityHint("Opens Wikipedia at the entered coordinates")
            }
        }
        .navigationTitle("Custom Location")
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Invalid Input"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
        }
    }
}
