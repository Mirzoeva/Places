//
//  LocationRowViewTests.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import XCTest
import SwiftUI
@testable import WikipediaPlacesLauncher

final class LocationRowViewTests: XCTestCase {
    func test_onTapCallbackIsCalled() {
        let location = Location(name: "Test City", latitude: 1.0, longitude: 2.0)
        var wasTapped = false

        let view = PlaceRowView(location: location) { _ in
            wasTapped = true
        }

        view.onTap(location)
        XCTAssertTrue(wasTapped)
    }
}
