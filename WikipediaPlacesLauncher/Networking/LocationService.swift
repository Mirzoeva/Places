//
//  LocationService.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import Foundation

protocol LocationServiceProtocol {
    func fetchLocations() async throws -> [Location]
}

final class LocationService: LocationServiceProtocol {
    private let url = URL(string: "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json")

    func fetchLocations() async throws -> [Location] {
        guard let url else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        let decoded = try JSONDecoder().decode(LocationResponse.self, from: data)
        return decoded.locations
    }
}

