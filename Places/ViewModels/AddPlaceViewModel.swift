//
//  AddPlaceViewModel.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import Foundation

final class AddPlaceViewModel: ObservableObject {
    @Published var name = ""
    @Published var latitude = ""
    @Published var longitude = ""

    private func parseCoordinates() throws -> (lat: Double, lon: Double) {
        guard let lat = Double(latitude), let lon = Double(longitude) else {
            throw PError.Validation.invalidNumbers
        }
        return (lat, lon)
    }

    func validateInput() throws -> (latitude: Double, longitude: Double) {
        let (lat, lon) = try parseCoordinates()

        guard (-90...90).contains(lat) else {
            throw PError.Validation.latitudeOutOfBounds
        }

        guard (-180...180).contains(lon) else {
            throw PError.Validation.longitudeOutOfBounds
        }

        return (lat, lon)
    }

    func buildLocation() throws -> Location {
        let (lat, lon) = try validateInput()
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)

        return Location(
            name: trimmedName.isEmpty ? nil : trimmedName,
            latitude: lat,
            longitude: lon
        )
    }
}
