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
            Text(location.name ?? AppStrings.UI.unnamedLocation)
                .font(.headline)
            
            Text(AppStrings.Format.coordinates(lat: location.latitude, lon: location.longitude))
                .foregroundColor(.secondary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        )
        .contentShape(Rectangle())
        .onTapGesture {
            openWikipedia()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(location.name ?? "Unnamed"), latitude \(location.latitude), longitude \(location.longitude)")
        .accessibilityHint(AppStrings.Accessibility.openHint)
    }
    
    private func openWikipedia() {
        guard let url = DeepLinkBuilder.wikipediaURL(for: location) else { return }
        UIApplication.shared.open(url)
    }
}
