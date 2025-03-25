//
//  LocationsView.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import SwiftUI

struct LocationsView: View {
    @StateObject private var viewModel = LocationsViewModel()
    @State private var showingAddSheet = false
    @State private var didLoad = false

    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView(AppStrings.UI.loading)
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    VStack(spacing: 16) {
                        Text(error)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)

                        Button(AppStrings.UI.retry) {
                            Task { await viewModel.fetchInitialLocations() }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List {
                        ForEach(viewModel.locations) { location in
                            LocationRowView(location: location) { selected in
                                handleLocationTap(selected)
                            }
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: viewModel.deleteLocation)
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle(AppStrings.UI.placesTitle)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel(AppStrings.Accessibility.addPlace)
                }
            }
            .sheet(isPresented: $showingAddSheet) {
                AddLocationSheet { name, lat, lon in
                    viewModel.addCustomLocation(name: name, latitude: lat, longitude: lon)
                }
            }
            .onAppear {
                guard !didLoad else { return }
                didLoad = true
                Task { await viewModel.fetchInitialLocations() }
            }
            .background(Color(.systemGroupedBackground).ignoresSafeArea())
        }
    }
    
    private func handleLocationTap(_ location: Location) {
        guard let url = DeepLinkBuilder.wikipediaURL(for: location) else { return }
        UIApplication.shared.open(url)
    }
}
