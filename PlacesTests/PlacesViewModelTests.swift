//
//  PlacesViewModelTests.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import XCTest
@testable import Places

@MainActor
final class PlacesViewModelTests: XCTestCase {

    func test_fetchInitialLocations_successfullyUpdatesLocations() async {
        let mockService = MockLocationService()
        let viewModel = PlacesViewModel(locationService: mockService)

        await viewModel.fetchLocations()

        XCTAssertEqual(viewModel.locations.count, 2)
        XCTAssertEqual(viewModel.locations.first?.name, "Amsterdam")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func test_fetchInitialLocations_allLocationsAreReturnedIncludingNilNames() async {
        let mockService = MixedNameMockLocationService()
        let viewModel = PlacesViewModel(locationService: mockService)

        await viewModel.fetchLocations()

        XCTAssertEqual(viewModel.locations.count, 2)
        XCTAssertEqual(viewModel.locations[0].name, "Valid City")
        XCTAssertNil(viewModel.locations[1].name)
    }

    func test_fetchInitialLocations_setsErrorOnFailure() async {
        let brokenService = BrokenLocationService()
        let viewModel = PlacesViewModel(locationService: brokenService)

        await viewModel.fetchLocations()

        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.locations.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }
}
