//
//  Location.swift
//  favplaces
//
//  Created by Goodness Ade on 2024-12-26.
////
//
import Foundation
import MapKit

//
// struct Location: Codable, Identifiable, Equatable {
//    var id: UUID
//    var name: String
//    var description: String
//    var latitude: Double
//    var longitude: Double
//
//    var coordinate: CLLocationCoordinate2D { CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//    }
//
//    #if DEBUG
//    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Lit place", latitude: 51.501, longitude: -0.141)
//    #endif
// }
// struct Location: Codable, Identifiable, Equatable, Hashable {
//    var id: UUID
//    var name: String
//    var description: String
//    var latitude: Double
//    var longitude: Double
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, description, latitude, longitude
//    }
//
//    init(id: UUID, name: String, description: String, latitude: Double, longitude: Double) {
//        self.id = id
//        self.name = name
//        self.description = description
//        self.latitude = latitude
//        self.longitude = longitude
//    }
//
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        if let stringId = try? container.decode(String.self, forKey: .id) {
//            id = UUID()
//        } else {
//            id = try container.decode(UUID.self, forKey: .id)
//        }
//        name = try container.decode(String.self, forKey: .name)
//        description = try container.decode(String.self, forKey: .description)
//        latitude = try container.decode(Double.self, forKey: .latitude)
//        longitude = try container.decode(Double.self, forKey: .longitude)
//    }
//
//    var coordinate: CLLocationCoordinate2D {
//        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
//    }
//
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(latitude)
//        hasher.combine(longitude)
//        hasher.combine(id)
//    }
//
//    static func == (lhs: Location, rhs: Location) -> Bool {
//        lhs.id == rhs.id
//    }
//
//    #if DEBUG
//    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Lit place", latitude: 51.501, longitude: -0.141)
//    #endif
// }
//
//  Location.swift
//  favplaces
//
//  Created by sammy hutchinson on 2024-12-26.
//

import Foundation
import MapKit

struct Location: Codable, Identifiable, Equatable {
    var id: UUID
    var name: String
    var description: String
    var latitude: Double
    var longitude: Double

    var coordinate: CLLocationCoordinate2D { CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }

    #if DEBUG
    static let example = Location(id: UUID(), name: "Buckingham Palace", description: "Lit place", latitude: 51.501, longitude: -0.141)
    #endif
}
