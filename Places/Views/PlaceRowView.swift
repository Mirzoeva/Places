//
//  PlaceRowView.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import SwiftUI

struct PlaceRowView: View {
    let place: Location

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(place.name ?? AppStrings.UI.unnamedPlace)
                .font(.headline)

            Text(AppStrings.Format.coordinates(lat: place.latitude, lon: place.longitude))
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
            openWikipedia()
        }
        .padding(.horizontal)
        .padding(.vertical, 4)
    }

    private func openWikipedia() {
        guard let url = DeepLinkBuilder.wikipediaURL(for: place) else { return }
        UIApplication.shared.open(url)
    }
}
