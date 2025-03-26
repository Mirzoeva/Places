//
//  PlacesView.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import SwiftUI

struct PlacesView: View {
    @StateObject private var viewModel = PlacesViewModel()
    @State private var addPlaceVM = AddPlaceViewModel()
    @State private var showingAddPopup = false
    @State private var hasFetched = false
    @State private var errorAlert: ErrorAlert?

    var body: some View {
        NavigationView {
            ZStack {
                backgroundView
                content
                addPopupOverlay
                floatingAddButton
            }
            .navigationTitle("places.placesTitle")
            .navigationBarTitleDisplayMode(.inline)
            .task {
                guard !hasFetched else { return }
                hasFetched = true
                await viewModel.fetchLocations()
            }
            .alert(item: $errorAlert) { error in
                Alert(
                    title: Text("places.error"),
                    message: Text(error.message),
                    dismissButton: .default(Text("places.ok"))
                )
            }
        }
    }

    // MARK: - Content

    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView("places.loading")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let error = viewModel.errorMessage {
            VStack(spacing: 16) {
                Text(error)
                    .foregroundColor(.red)
                Button("places.retry") {
                    fetchPlaces()
                }
                .buttonStyle(.borderedProminent)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            List {
                ForEach(viewModel.locations) { place in
                    PlaceRowView(place: place)
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                }
                .onDelete { indexSet in
                    viewModel.deleteLocation(at: indexSet)
                }
            }
            .listStyle(.plain)
            .animation(.default, value: viewModel.locations)
        }
    }

    // MARK: - Popup

    @ViewBuilder
    private var addPopupOverlay: some View {
        if showingAddPopup {
            Color.black.opacity(0.3)
                .ignoresSafeArea()
                .transition(.opacity)

            AddPlacePopup(
                viewModel: addPlaceVM,
                onAdd: { name, lat, lon in
                    viewModel.addCustomLocation(name: name, latitude: lat, longitude: lon)
                    showingAddPopup = false
                },
                onCancel: {
                    showingAddPopup = false
                }
            )
            .transition(.scale)
        }
    }

    // MARK: - Floating Button

    private var floatingAddButton: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button {
                    withAnimation {
                        showingAddPopup = true
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .frame(width: 56, height: 56)
                        .background(Color.blue)
                        .clipShape(Circle())
                        .shadow(radius: 4)
                        .padding()
                }
            }
        }
    }

    // MARK: - Helpers

    private var backgroundView: some View {
        Color(.systemGroupedBackground).ignoresSafeArea()
    }

    private func fetchPlaces() {
        Task {
            await viewModel.fetchLocations()
        }
    }
}
