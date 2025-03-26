//
//  AddPlaceViewModelTests.swift
//  Places
//
//  Created by Ума Мирзоева on 26/03/2025.
//

import XCTest
@testable import Places

final class AddPlaceViewModelTests: XCTestCase {
    var viewModel: AddPlaceViewModel!

    override func setUp() {
        super.setUp()
        viewModel = AddPlaceViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testBuildLocation_WithValidInput_ReturnsLocation() throws {
        viewModel.name = "Test Place"
        viewModel.latitude = "45.0"
        viewModel.longitude = "90.0"

        let location = try viewModel.buildLocation()

        XCTAssertEqual(location.name, "Test Place")
        XCTAssertEqual(location.latitude, 45.0, accuracy: 0.0001)
        XCTAssertEqual(location.longitude, 90.0, accuracy: 0.0001)
    }

    func testBuildLocation_EmptyCoordinates_ThrowsInvalidNumbers() {
        viewModel.name = "Place"
        viewModel.latitude = ""
        viewModel.longitude = ""

        XCTAssertThrowsError(try viewModel.buildLocation()) { error in
            XCTAssertEqual(error as? PError.Validation, .invalidNumbers)
        }
    }

    func testBuildLocation_LatitudeOutOfBounds_ThrowsError() {
        viewModel.name = "Place"
        viewModel.latitude = "100"
        viewModel.longitude = "50"

        XCTAssertThrowsError(try viewModel.buildLocation()) { error in
            XCTAssertEqual(error as? PError.Validation, .latitudeOutOfBounds)
        }
    }

    func testBuildLocation_LongitudeOutOfBounds_ThrowsError() {
        viewModel.name = "Place"
        viewModel.latitude = "45"
        viewModel.longitude = "200"

        XCTAssertThrowsError(try viewModel.buildLocation()) { error in
            XCTAssertEqual(error as? PError.Validation, .longitudeOutOfBounds)
        }
    }

    func testBuildLocation_EmptyName_ReturnsNilName() throws {
        viewModel.name = "   "
        viewModel.latitude = "30.0"
        viewModel.longitude = "60.0"

        let location = try viewModel.buildLocation()
        XCTAssertNil(location.name)
        XCTAssertEqual(location.latitude, 30.0)
        XCTAssertEqual(location.longitude, 60.0)
    }
}
