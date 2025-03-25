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
            alertMessage = AppStrings.Errors.invalidCoordinates
            showAlert = true
            return
        }
        
        guard (-90...90).contains(lat), (-180...180).contains(lon) else {
            alertMessage = AppStrings.Errors.invalidCoordinates
            showAlert = true
            return
        }


        let location = Location(name: AppStrings.UI.customLocationTitle, latitude: lat, longitude: lon)
        if let url = DeepLinkBuilder.wikipediaURL(for: location) {
            UIApplication.shared.open(url)
        }
    }
}


