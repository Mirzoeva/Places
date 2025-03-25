//
//  LocationRowView.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import SwiftUI

struct LocationRowView: View {
    let location: Location
    let onTap: (Location) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(location.name ?? AppStrings.UI.unnamedPlace)
                .font(.headline)

            Text(AppStrings.Format.coordinates(lat: location.latitude, lon: location.longitude))
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.secondarySystemBackground))
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            onTap(location)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(AppStrings.Format.accessibilityPlace(
            name: location.name ?? AppStrings.UI.unnamedPlace,
            lat: location.latitude,
            lon: location.longitude
        ))
        .accessibilityHint(AppStrings.Accessibility.locationTapHint)
        .padding(.horizontal)
        .padding(.vertical, 4)
    }
}
