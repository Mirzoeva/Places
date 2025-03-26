//
//  LocationService.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import Foundation

// MARK: - Protocol

protocol LocationServiceProtocol {
    func fetchLocations() async throws -> [Location]
}

// MARK: - Implementation

final class LocationService: LocationServiceProtocol {
    private let endpoint: String

    init(endpoint: String = AppConstants.Network.placesEndpoint) {
        self.endpoint = endpoint
    }

    func fetchLocations() async throws -> [Location] {
        guard let url = URL(string: endpoint) else {
            throw PError.LocationService.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }
        
        do {
            let decoded = try JSONDecoder().decode(LocationResponse.self, from: data)
            return decoded.locations
        } catch {
            throw PError.LocationService.decodingFailed(error)
        }
    }
}
