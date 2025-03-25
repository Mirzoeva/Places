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
        VStack(alignment: .leading) {
            Text(location.name)
                .font(.headline)
            Text("Lat: \(location.latitude), Lon: \(location.longitude)")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 4)
    }
}

