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
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading locations...")
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                        Button("Retry") {
                            Task {
                                await viewModel.fetchLocations()
                            }
                        }
                        .padding(.top)
                    }
                } else {
                    List(viewModel.locations) { location in
                        LocationRowView(location: location)
                    }
                }
            }
            .navigationTitle("Locations")
        }
        .task {
            await viewModel.fetchLocations()
        }
    }
}

