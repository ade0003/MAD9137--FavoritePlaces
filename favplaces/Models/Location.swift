
import Foundation
import MapKit

// represents a location with its coordinates and metadata
struct Location: Codable, Identifiable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double

    // this converts lat/long to a map coordinate
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    // this creates a new location from places.json
    init(name: String, description: String, latitude: Double, longitude: Double) {
        self.id = UUID()
        self.name = name
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
    }

    // this is the full initializer with all properties
    init(id: UUID, name: String, description: String, latitude: Double, longitude: Double) {
        self.id = id
        self.name = name
        self.description = description
        self.latitude = latitude
        self.longitude = longitude
    }
}
