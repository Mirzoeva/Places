//
//  AddPlaceViewModel.swift
//  WikipediaPlacesLauncher
//
//  Created by Ума Мирзоева on 25/03/2025.
//

import Foundation

final class AddPlaceViewModel: ObservableObject {
    @Published var name = ""
    @Published var latitude = ""
    @Published var longitude = ""
    @Published var alert: AlertMessage?
    
    func validateInput() -> Bool {
        guard let lat = Double(latitude),
              let lon = Double(longitude) else {
            alert = AlertMessage(text: AppStrings.Errors.invalidInput)
            return false
        }
        
        guard (-90...90).contains(lat), (-180...180).contains(lon) else {
            alert = AlertMessage(text: AppStrings.Errors.invalidCoordinates)
            return false
        }
        
        return true
    }
    
    func buildLocation() -> (String?, Double, Double) {
        let lat = Double(latitude)!
        let lon = Double(longitude)!
        let locationName = name.isEmpty ? nil : name
        return (locationName, lat, lon)
    }
}
