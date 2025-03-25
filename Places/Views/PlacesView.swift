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
    @State private var didLoad = false
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundView
                
                content
                
                if showingAddPopup {
                    Color.black.opacity(0.3)
                        .ignoresSafeArea()
                        .transition(.opacity)
                    
                    AddPlacePopup(viewModel: addPlaceVM, onAdd: { name, lat, lon in
                        viewModel.addCustomLocation(name: name, latitude: lat, longitude: lon)
                        showingAddPopup = false
                    }, onCancel: {
                        showingAddPopup = false
                    })
                    .transition(.scale)
                }
                
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
            .navigationTitle(AppStrings.UI.placesTitle)
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                guard !didLoad else { return }
                didLoad = true
                Task { await viewModel.fetchInitialLocations() }
            }
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading {
            ProgressView(AppStrings.UI.loading)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else if let error = viewModel.errorMessage {
            VStack(spacing: 16) {
                Text(error)
                    .foregroundColor(.red)
                Button(AppStrings.UI.retry) {
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
                .onDelete(perform: viewModel.deleteLocation(at:))
            }
            .listStyle(.plain)
        }
    }
    
    private var backgroundView: some View {
        Color(.systemGroupedBackground).ignoresSafeArea()
    }
    
    private func fetchPlaces() {
        Task {
            await viewModel.fetchInitialLocations()
        }
    }
}
