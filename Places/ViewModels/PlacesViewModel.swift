//
//  PlacesViewModel.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import Foundation

@MainActor
final class PlacesViewModel: ObservableObject {
    @Published var locations: [Location] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let locationService: LocationServiceProtocol

    init(locationService: LocationServiceProtocol = LocationService()) {
        self.locationService = locationService
    }

    func fetchLocations() async {
        isLoading = true
        errorMessage = nil

        do {
            let remote = try await locationService.fetchLocations()
            locations = remote
        } catch {
            errorMessage = "places.loadingFailed"
        }

        isLoading = false
    }

    func addCustomLocation(name: String?, latitude: Double, longitude: Double) {
        let location = Location(name: name, latitude: latitude, longitude: longitude)
        locations.append(location)
    }

    func deleteLocation(at offsets: IndexSet) {
        locations.remove(atOffsets: offsets)
    }
}
