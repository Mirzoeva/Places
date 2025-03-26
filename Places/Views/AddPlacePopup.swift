//
//  AddPlacePopup.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import SwiftUI

struct AddPlacePopup: View {
    @ObservedObject var viewModel: AddPlaceViewModel
    @State private var showErrorAlert = false
    @State private var errorMessage = ""

    let onAdd: (String?, Double, Double) -> Void
    let onCancel: () -> Void

    var body: some View {
        ZStack {
            VStack(spacing: 16) {
                Text("places.addPlace")
                    .font(.headline)
                
                TextField("places.name", text: $viewModel.name)
                    .textFieldStyle(.roundedBorder)
                
                TextField("places.latitudeField", text: $viewModel.latitude)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                
                TextField("places.longitudeField", text: $viewModel.longitude)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(.roundedBorder)
                
                HStack {
                    Button("places.cancel") {
                        onCancel()
                    }
                    
                    Spacer()
                    
                    Button("places.add") {
                        do {
                            let location = try viewModel.buildLocation()
                            onAdd(location.name, location.latitude, location.longitude)
                        } catch {
                            errorMessage = error.localizedDescription
                            showErrorAlert = true
                        }
                    }
                    .buttonStyle(.borderedProminent)
                }
            }
            .padding()
            .frame(maxWidth: 300)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
                    .shadow(radius: 8)
            )
            .padding()
        }
        .alert("places.error", isPresented: $showErrorAlert) {
            Button("places.ok", role: .cancel) { }
        } message: {
            Text(errorMessage)
        }
    }
}
