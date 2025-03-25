//
//  LocationListViewModelTests.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import XCTest
@testable import WikipediaPlacesLauncher

@MainActor
final class LocationListViewModelTests: XCTestCase {

    func test_fetchLocations_successfullyUpdatesLocations() async {
        let mockService = MockLocationService()
        let viewModel = LocationListViewModel(locationService: mockService)

        await viewModel.fetchLocations()

        XCTAssertEqual(viewModel.locations.count, 2)
        XCTAssertEqual(viewModel.locations.first?.name, "Amsterdam")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertFalse(viewModel.isLoading)
    }

    func test_fetchLocations_allLocationsAreReturnedIncludingNilNames() async {
        let mockService = MixedNameMockLocationService()
        let viewModel = LocationListViewModel(locationService: mockService)

        await viewModel.fetchLocations()

        XCTAssertEqual(viewModel.locations.count, 2)
        XCTAssertEqual(viewModel.locations[0].name, "Valid City")
        XCTAssertNil(viewModel.locations[1].name)
    }

    func test_fetchLocations_setsErrorOnFailure() async {
        let brokenService = BrokenLocationService()
        let viewModel = LocationListViewModel(locationService: brokenService)

        await viewModel.fetchLocations()

        XCTAssertNotNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.locations.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
    }
}
