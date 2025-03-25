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
        NavigationView {
            VStack(spacing: 0) {
                Form {
                    Section(header: Text(AppStrings.UI.enterCoordinates)) {
                        TextField(AppStrings.Accessibility.latitudeField, text: $viewModel.latitudeText)
                            .keyboardType(.decimalPad)
                            .accessibilityLabel(AppStrings.Accessibility.latitudeField)

                        TextField(AppStrings.Accessibility.longitudeField, text: $viewModel.longitudeText)
                            .keyboardType(.decimalPad)
                            .accessibilityLabel(AppStrings.Accessibility.longitudeField)
                    }
                }
                .scrollContentBackground(.hidden)

                Button(action: {
                    viewModel.openWikipediaIfValid()
                }) {
                    Text(AppStrings.UI.openInWikipedia)
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .padding()
                .accessibilityHint(AppStrings.Accessibility.openHint)
            }
            .navigationTitle(AppStrings.UI.customLocationTitle)
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text(AppStrings.Errors.invalidInput),
                    message: Text(viewModel.alertMessage),
                    dismissButton: .default(Text(AppStrings.UI.ok))
                )
            }
        }
    }
}
