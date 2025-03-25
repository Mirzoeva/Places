//
//  LocationRowView.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import SwiftUI

struct LocationRowView: View {
    let location: Location

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(location.name ?? "Unnamed Location")
                .font(.headline)
            Text("Lat: \(location.latitude), Lon: \(location.longitude)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
        .onTapGesture {
            openWikipedia(for: location)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(location.name ?? "Unnamed"), latitude \(location.latitude), longitude \(location.longitude)")
        .accessibilityHint("Opens Wikipedia Places at this location")
    }

    private func openWikipedia(for location: Location) {
        if let url = DeepLinkBuilder.wikipediaURL(for: location) {
            UIApplication.shared.open(url)
        }
    }
}
