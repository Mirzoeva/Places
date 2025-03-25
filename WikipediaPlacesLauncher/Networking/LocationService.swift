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
    private let url = URL(string: "https://raw.githubusercontent.com/abnamrocoesd/assignment-ios/main/locations.json")!

    func fetchLocations() async throws -> [Location] {
        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        let decoder = JSONDecoder()
        let decoded = try decoder.decode(LocationResponse.self, from: data)
        return decoded.locations
    }
}
