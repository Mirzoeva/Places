//
//  CustomLocationViewModel.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import SwiftUI

final class CustomLocationViewModel: ObservableObject {
    @Published var latitudeText: String = ""
    @Published var longitudeText: String = ""
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    func openWikipediaIfValid() {
        guard let lat = Double(latitudeText),
              let lon = Double(longitudeText) else {
            alertMessage = "Please enter valid numeric coordinates."
            showAlert = true
            return
        }

        let location = Location(name: "Custom Location", latitude: lat, longitude: lon)
        if let url = DeepLinkBuilder.wikipediaURL(for: location) {
            UIApplication.shared.open(url)
        }
    }
}


