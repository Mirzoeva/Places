//
//  CustomLocationViewModelTests.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import XCTest
@testable import WikipediaPlacesLauncher

final class CustomLocationViewModelTests: XCTestCase {
    var viewModel: CustomLocationViewModel!

    override func setUp() {
        super.setUp()
        viewModel = CustomLocationViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func test_invalidCoordinates_showsNumericValidationError() {
        viewModel.latitudeText = "abc"
        viewModel.longitudeText = "123"

        viewModel.openWikipediaIfValid()

        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, AppStrings.Errors.invalidInput)
    }

    func test_outOfRangeCoordinates_showsRangeValidationError() {
        viewModel.latitudeText = "999"
        viewModel.longitudeText = "123"

        viewModel.openWikipediaIfValid()

        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.alertMessage, AppStrings.Errors.invalidCoordinates)
    }

    func test_validCoordinates_generatesValidURL() {
        viewModel.latitudeText = "52.37"
        viewModel.longitudeText = "4.89"

        let location = Location(name: nil, latitude: 52.37, longitude: 4.89)
        let expectedURL = DeepLinkBuilder.wikipediaURL(for: location)

        XCTAssertNotNil(expectedURL)
        XCTAssertEqual(expectedURL?.absoluteString, "wikipedia://places?lat=52.37&lon=4.89")
    }
}
