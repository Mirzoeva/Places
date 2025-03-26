//
//  PError.swift
//  Places
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import Foundation

enum PError {
    typealias Validation = ValidationError
    typealias LocationService = LocationServiceError
}

struct ErrorAlert: Identifiable {
    let id = UUID()
    let message: String
}

// MARK: - Validation Errors

enum ValidationError: LocalizedError {
    case invalidNumbers
    case latitudeOutOfBounds
    case longitudeOutOfBounds

    var errorDescription: String? {
        switch self {
        case .invalidNumbers:
            return String(localized: "places.invalidNumbers")
        case .latitudeOutOfBounds:
            return String(localized: "places.latitude_out_of_bounds")
        case .longitudeOutOfBounds:
            return String(localized: "places.longitude_out_of_bounds")
        }
    }
}

// MARK: - Location Service Errors

enum LocationServiceError: LocalizedError {
    case invalidURL
    case fetchFailed(Error)
    case decodingFailed(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return String(localized: "error.location_service.invalid_url")
        case .fetchFailed:
            return String(localized: "error.location_service.fetch_failed")
        case .decodingFailed:
            return String(localized: "error.location_service.decoding_failed")
        }
    }
}
