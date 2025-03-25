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
        static let loadingFailed = "Failed to load places"
        static let error = "Error"
    }

    enum UI {
        static let ok = "ok"
        static let loading = "Loading places..."
        static let retry = "Retry"
        static let placesTitle = "Places"
        static let name = "Name (optional)"
        static let unnamedPlace = "Unnamed place"
        static let addPlace = "Add place"
    }

    enum Accessibility {
        static let latitudeField = "Latitude"
        static let longitudeField = "Longitude"
        static let locationTapHint = "locationTapHint"
        static let addPlace = "Add place"
    }
    
    enum Format {
            static func coordinates(lat: Double, lon: Double) -> String {
                "Lat: \(lat), Lon: \(lon)"
            }

            static func accessibilityPlace(name: String, lat: Double, lon: Double) -> String {
                "\(name), latitude \(lat), longitude \(lon)"
            }
        }
}

