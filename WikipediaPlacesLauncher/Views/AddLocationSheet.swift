//
//  AddLocationSheet.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import SwiftUI

struct AddLocationSheet: View {
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var latitude = ""
    @State private var longitude = ""
    @State private var showAlert = false
    @State private var alertMessage = ""

    let onAdd: (String?, Double, Double) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField(AppStrings.UI.name, text: $name)
                    TextField(AppStrings.Accessibility.latitudeField, text: $latitude)
                        .keyboardType(.decimalPad)
                    TextField(AppStrings.Accessibility.longitudeField, text: $longitude)
                        .keyboardType(.decimalPad)
                }

                Section {
                    Button(action: handleAdd) {
                        Text(AppStrings.UI.addPlace)
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .controlSize(.large)
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .listRowInsets(EdgeInsets())
                }

            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(AppStrings.Errors.error),
                    message: Text(alertMessage),
                    dismissButton: .default(Text(AppStrings.UI.ok))
                )
            }
        }
    }

    private func handleAdd() {
        guard let lat = Double(latitude),
              let lon = Double(longitude) else {
            alertMessage = AppStrings.Errors.invalidInput
            showAlert = true
            return
        }

        guard (-90...90).contains(lat), (-180...180).contains(lon) else {
            alertMessage = AppStrings.Errors.invalidCoordinates
            showAlert = true
            return
        }

        onAdd(name.isEmpty ? nil : name, lat, lon)
        dismiss()
    }
}
