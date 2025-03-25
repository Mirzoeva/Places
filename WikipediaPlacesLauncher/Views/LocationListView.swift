//
//  LocationListView.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import SwiftUI

struct LocationListView: View {
    @StateObject private var viewModel = LocationListViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView(AppStrings.UI.loading)
                        .progressViewStyle(CircularProgressViewStyle())
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Text(error)
                            .font(.headline)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        Button(AppStrings.UI.retry) {
                            Task {
                                await viewModel.fetchLocations()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    ScrollView {
                        LazyVStack(spacing: 12) {
                            ForEach(viewModel.locations) { location in
                                LocationRowView(location: location)
                                    .padding(.horizontal)
                                    .transition(.opacity)
                            }
                        }
                        .padding(.top)
                    }
                }
            }
            .navigationTitle(AppStrings.UI.placesTitle)
        }
        .task {
            await viewModel.fetchLocations()
        }
    }
}
