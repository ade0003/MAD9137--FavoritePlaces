
import CoreLocation
import Foundation
import MapKit

@Observable
class LocationViewModel {
    // this stores all the locations
    private(set) var locations: [Location] = []
    // this is where I save locations on disk

    let savePath = URL.documentsDirectory.appending(path: "savedPlaces")
    var selectedPlace: Location?

    init() {
        locations = loadJSONLocations()
    }

    // this loads predefined locations from the json file

    private func loadJSONLocations() -> [Location] {
        guard let url = Bundle.main.url(forResource: "places", withExtension: "json") else {
            print("❌ json file not found")
            return []
        }

        guard let data = try? Data(contentsOf: url) else {
            print("❌ couldn't read data")
            return []
        }

        print("📄 Initial JSON:", String(data: data, encoding: .utf8) ?? "")

        // this defines temporary struct matching json format
        struct JSONLocation: Codable {
            let name: String
            let description: String
            let latitude: Double
            let longitude: Double
        }

        do {
            // this converts json data into our location objects

            let jsonLocations = try JSONDecoder().decode([JSONLocation].self, from: data)
            print("✅ Decoded JSON locations:", jsonLocations)

            let locations = jsonLocations.map { json in
                print("🔄 Converting location:", json)
                return Location(id: UUID(),
                                name: json.name,
                                description: json.description,
                                latitude: json.latitude,
                                longitude: json.longitude)
            }
            print("✅ Final locations:", locations)
            return locations
        } catch {
            print("❌ JSON decode error:", error)
            return []
        }
    }

    // this saves locations to persistent storage

    func save() {
        do {
            let data = try JSONEncoder().encode(locations)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("❌ unable to save data: \(error)")
        }
    }

    // this adds a new location at the tapped coordinate

    func addLocation(at point: CLLocationCoordinate2D) {
        let newLocation = Location(id: UUID(),
                                   name: "New Location",
                                   description: "",
                                   latitude: point.latitude,
                                   longitude: point.longitude)
        locations.append(newLocation)
        save()
    }

    // this updates an existing location

    func updateLocation(location: Location) {
        guard let selectedPlace else { return }
        if let index = locations.firstIndex(of: selectedPlace) {
            locations[index] = location
            save()
        }
    }

    // this removes locations at specified positions

    func deleteLocation(at offsets: IndexSet) {
        locations.remove(atOffsets: offsets)
        save()
    }

    // this resets to initial locations from json

    func clearSavedLocations() {
        locations = loadJSONLocations()
        save()
    }
}
