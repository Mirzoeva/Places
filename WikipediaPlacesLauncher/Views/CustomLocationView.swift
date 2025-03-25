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
        VStack {
            Form {
                Section(header: Text("Enter Coordinates")) {
                    TextField("Latitude", text: $viewModel.latitudeText)
                        .keyboardType(.decimalPad)
                    TextField("Longitude", text: $viewModel.longitudeText)
                        .keyboardType(.decimalPad)
                }
            }

            Button(action: {
                viewModel.openWikipediaIfValid()
            }) {
                Text("Open in Wikipedia")
                    .frame(maxWidth: .infinity)
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
        }
        .navigationTitle("Custom Location")
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Invalid Input"),
                  message: Text(viewModel.alertMessage),
                  dismissButton: .default(Text("OK")))
        }

    }
}

