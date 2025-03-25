//
//  LocationListViewModel.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import Foundation

@MainActor
final class LocationListViewModel: ObservableObject {
    // MARK: - Public state

    @Published var locations: [Location] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    // MARK: - Dependencies

    private let locationService: LocationServiceProtocol

    // MARK: - Init

    init(locationService: LocationServiceProtocol = LocationService()) {
        self.locationService = locationService
    }

    // MARK: - Public API

    func fetchLocations() async {
        isLoading = true
        errorMessage = nil

        do {
            let result = try await locationService.fetchLocations()
            locations = result
        } catch {
            errorMessage = AppStrings.Errors.loadingFailed
        }

        isLoading = false
    }
}
