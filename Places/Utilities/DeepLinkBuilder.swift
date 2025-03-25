//
//  DeepLinkBuilder.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//
import Foundation

struct DeepLinkBuilder {
    static func wikipediaURL(for location: Location) -> URL? {
        var components = URLComponents()
        components.scheme = "wikipedia"
        components.host = "places"
        components.queryItems = [
            URLQueryItem(name: "lat", value: "\(location.latitude)"),
            URLQueryItem(name: "lon", value: "\(location.longitude)")
        ]
        return components.url
    }
}

