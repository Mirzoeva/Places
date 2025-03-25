//
//  WikipediaPlacesLauncherApp.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import SwiftUI

@main
struct WikipediaPlacesLauncherApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                LocationListView()
                    .tabItem {
                        Label("Places", systemImage: "map")
                    }

                CustomLocationView()
                    .tabItem {
                        Label("Custom", systemImage: "location.fill")
                    }
            }
        }
    }
}
