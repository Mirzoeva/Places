//
//  LocationServiceTests.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import XCTest
@testable import WikipediaPlacesLauncher

final class LocationServiceTests: XCTestCase {

    func test_fetchLocations_successfullyParsesMockedJSON() async throws {
        let mockService = MockLocationService()
        let locations = try await mockService.fetchLocations()
        XCTAssertEqual(locations.count, 2)
        XCTAssertEqual(locations[0].name, "Amsterdam")
    }

    func test_fetchLocations_throwsOnInvalidURL() async {
        let brokenService = BrokenLocationService()
        do {
            _ = try await brokenService.fetchLocations()
            XCTFail("Expected error, but got success")
        } catch {
            XCTAssertTrue(error is URLError)
        }
    }

}
