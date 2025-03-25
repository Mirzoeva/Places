//
//  AppStrings.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import Foundation

enum AppStrings {
    enum Errors {
        static let invalidInput = "Please enter valid numeric coordinates."
        static let invalidCoordinates = "Coordinates must be valid: -90…90 for latitude, -180…180 for longitude."
        static let loadingFailed = "Failed to load locations"
    }

    enum UI {
        static let loading = "Loading locations..."
        static let retry = "Retry"
        static let placesTitle = "Places"
        static let customLocationTitle = "Custom Location"
        static let openInWikipedia = "Open in Wikipedia"
        static let unnamedLocation = "Unnamed Location"
        static let enterCoordinates = "Enter Coordinates"
        static let ok = "ok"
    }

    enum Accessibility {
        static let latitudeField = "Latitude"
        static let longitudeField = "Longitude"
        static let openHint = "Opens Wikipedia at the entered coordinates"
    }
    
    enum Format {
            static func coordinates(lat: Double, lon: Double) -> String {
                "Lat: \(lat), Lon: \(lon)"
            }

            static func accessibilityLocation(name: String, lat: Double, lon: Double) -> String {
                "\(name), latitude \(lat), longitude \(lon)"
            }
        }
}

