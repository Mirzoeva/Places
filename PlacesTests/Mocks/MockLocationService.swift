//
//  MockLocationService.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import Foundation
@testable import Places

final class MockLocationService: LocationServiceProtocol {
    func fetchLocations() async throws -> [Location] {
        return [
            Location(name: "Amsterdam", latitude: 52.37, longitude: 4.89),
            Location(name: "Rotterdam", latitude: 51.92, longitude: 4.48)
        ]
    }
}

final class MixedNameMockLocationService: LocationServiceProtocol {
    func fetchLocations() async throws -> [Location] {
        [
            Location(name: "Valid City", latitude: 1, longitude: 1),
            Location(name: nil, latitude: 2, longitude: 2)
        ]
    }
}

final class BrokenLocationService: LocationServiceProtocol {
    func fetchLocations() async throws -> [Location] {
        throw URLError(.badServerResponse)
    }
}

