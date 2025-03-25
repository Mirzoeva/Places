//
//  AddPlacePopup.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import SwiftUI

struct AddPlacePopup: View {
    @ObservedObject var viewModel: AddPlaceViewModel

    let onAdd: (String?, Double, Double) -> Void
    let onCancel: () -> Void

    var body: some View {
        VStack(spacing: 16) {
            Text(AppStrings.UI.addPlace)
                .font(.headline)

            TextField(AppStrings.UI.name, text: $viewModel.name)
                .textFieldStyle(.roundedBorder)

            TextField(AppStrings.UI.latitudeField, text: $viewModel.latitude)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)

            TextField(AppStrings.UI.longitudeField, text: $viewModel.longitude)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)

            HStack {
                Button(AppStrings.UI.cancel) {
                    onCancel()
                }

                Spacer()

                Button(AppStrings.UI.add) {
                    if viewModel.validateInput() {
                        let place = viewModel.buildLocation()
                        onAdd(place.0, place.1, place.2)
                    }
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .padding()
        .frame(maxWidth: 300)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(radius: 8)
        )
        .padding()
        .alert(item: $viewModel.alert) { alert in
            Alert(
                title: Text(AppStrings.Errors.error),
                message: Text(alert.text),
                dismissButton: .default(Text(AppStrings.UI.ok))
            )
        }
    }
}
