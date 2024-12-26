//
//  ContentView-ViewModel.swift
//  favplaces
//
//  Created by Goodness Ade on 2024-12-26.
//

import CoreLocation
import Foundation
import MapKit
import SwiftUI

//
// extension ContentView {
//    @Observable
//    class ViewModel {
//        private(set) var locations: [Location]
//        let savePath = URL.documentsDirectory.appending(path: "savedPlaces")
//        var selectedPlace: Location?
//
//        init() {
//            do {
//                let data = try Data(contentsOf: savePath)
//                locations = try JSONDecoder().decode([Location].self, from: data)
//            }
//            catch {
//                locations = []
//            }
//        }
//
//        func save() {
//            do {
//                let data = try JSONEncoder().encode(locations)
//                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
//            }
//            catch {
//                print("unable to save data.")
//            }
//        }
//
//        func addLocation(at point: CLLocationCoordinate2D) {
//            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: point.latitude, longitude: point.longitude)
//            locations.append(newLocation)
//            save()
//        }
//
//        func updateLocation(location: Location) {
//            guard let selectedPlace else { return }
//
//            if let index = locations.firstIndex(of: selectedPlace) {
//                locations[index] = location
//                save()
//            }
//        }
//
//        func deleteLocation(at offsets: IndexSet) {
//            locations.remove(atOffsets: offsets)
//            save()
//        }
//    }
// }
//
// extension ContentView {
//    @Observable
//    class ViewModel {
//        private(set) var locations: [Location]
//        let savePath = URL.documentsDirectory.appending(path: "savedPlaces")
//        var selectedPlace: Location?
//
//        init() {
//            self.locations = []
//
//            // Load initial locations from JSON
//            let initialLocations = loadInitialLocations()
//
//            // Load saved locations
//            if let savedLocations = try? loadSavedLocations() {
//                // Combine both arrays, avoiding duplicates by checking coordinates
//                self.locations = (initialLocations + savedLocations).reduce(into: [Location]()) { uniqueLocations, location in
//                    if !uniqueLocations.contains(where: { $0.latitude == location.latitude && $0.longitude == location.longitude }) {
//                        uniqueLocations.append(location)
//                    }
//                }
//                print("Total locations loaded:", locations.count)
//            } else {
//                self.locations = initialLocations
//            }
//        }
//
//        private func loadSavedLocations() throws -> [Location] {
//            let data = try Data(contentsOf: savePath)
//            return try JSONDecoder().decode([Location].self, from: data)
//        }
//
//        private func loadInitialLocations() -> [Location] {
//            guard let url = Bundle.main.url(forResource: "places", withExtension: "json"),
//                  let data = try? Data(contentsOf: url),
//                  let decodedLocations = try? JSONDecoder().decode([Location].self, from: data)
//            else {
//                print("Failed to load places.json")
//                return []
//            }
//
//            return decodedLocations.map { location in
//                Location(id: UUID(),
//                         name: location.name,
//                         description: location.description,
//                         latitude: location.latitude,
//                         longitude: location.longitude)
//            }
//        }
//
//        func save() {
//            do {
//                let data = try JSONEncoder().encode(locations)
//                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
//            } catch {
//                print("Unable to save data.")
//            }
//        }
//
//        func addLocation(at point: CLLocationCoordinate2D) {
//            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: point.latitude, longitude: point.longitude)
//            locations.append(newLocation)
//            save()
//        }
//
//        func updateLocation(location: Location) {
//            guard let selectedPlace else { return }
//            print("Updating location with ID: \(selectedPlace.id)")
//
//            var updatedLocation = location
//            updatedLocation.id = selectedPlace.id
//
//            if let index = locations.firstIndex(of: selectedPlace) {
//                locations[index] = updatedLocation
//                print("Location updated: \(locations[index])")
//                save()
//                // Reassign to trigger SwiftUI updates
//                locations = locations
//            }
//        }
//
//        func clearSavedLocations() {
//            locations = loadInitialLocations()
//            save()
//        }
//    }
// }
//
//  ContentView-ViewModel.swift
//  favplaces
//
//  Created by sammy hutchinson on 2024-12-26.
//

import CoreLocation
import Foundation
import MapKit

extension ContentView {
    @Observable
    class ViewModel {
        private(set) var locations: [Location]
        let savePath = URL.documentsDirectory.appending(path: "savedPlaces")
        var selectedPlace: Location?

        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            }
            catch {
                locations = []
            }
        }

        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            }
            catch {
                print("unable to save data.")
            }
        }

        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
            save()
        }

        func updateLocation(location: Location) {
            guard let selectedPlace else { return }

            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
                save()
            }
        }

        func deleteLocation(at offsets: IndexSet) {
            locations.remove(atOffsets: offsets)
            save()
        }

        func clearSavedLocations() {
            locations = []
            save()
        }
    }
}
