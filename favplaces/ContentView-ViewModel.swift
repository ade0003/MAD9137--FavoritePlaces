//
//
//// import CoreLocation
//// import Foundation
//// import MapKit
////
//// extension ContentView {
////    @Observable
////    class ViewModel {
////        private(set) var locations: [Location]
////        let savePath = URL.documentsDirectory.appending(path: "savedPlaces")
////        var selectedPlace: Location?
////
////        init() {
////            do {
////                let data = try Data(contentsOf: savePath)
////                locations = try JSONDecoder().decode([Location].self, from: data)
////            }
////            catch {
////                locations = []
////            }
////        }
////
////        func save() {
////            do {
////                let data = try JSONEncoder().encode(locations)
////                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
////            }
////            catch {
////                print("unable to save data.")
////            }
////        }
////
////        func addLocation(at point: CLLocationCoordinate2D) {
////            let newLocation = Location(id: UUID(), name: "New Location", description: "", latitude: point.latitude, longitude: point.longitude)
////            locations.append(newLocation)
////            save()
////        }
////
////        func updateLocation(location: Location) {
////            guard let selectedPlace else { return }
////
////            if let index = locations.firstIndex(of: selectedPlace) {
////                locations[index] = location
////                save()
////            }
////        }
////
////        func deleteLocation(at offsets: IndexSet) {
////            locations.remove(atOffsets: offsets)
////            save()
////        }
////
////        func clearSavedLocations() {
////            locations = []
////            save()
////        }
////    }
//// }
//
// import CoreLocation
// import Foundation
// import MapKit
//
// extension ContentView {
//    @Observable
//    class ViewModel {
//        private(set) var locations: [Location]
//        let savePath = URL.documentsDirectory.appending(path: "savedPlaces")
//        var selectedPlace: Location?
//
//        init() {
//            locations = []
//            locations = loadJSONLocations()
//        }
//
//        private func loadJSONLocations() -> [Location] {
//            guard let url = Bundle.main.url(forResource: "places", withExtension: "json"),
//                  let data = try? Data(contentsOf: url)
//            else {
//                return []
//            }
//
//            struct JSONLocation: Codable {
//                let id: String
//                let name: String
//                let description: String
//                let latitude: Double
//                let longitude: Double
//            }
//
//            do {
//                let jsonLocations = try JSONDecoder().decode([JSONLocation].self, from: data)
//                return jsonLocations.map { json in
//                    Location(id: UUID(),
//                             name: json.name,
//                             description: json.description,
//                             latitude: json.latitude,
//                             longitude: json.longitude)
//                }
//            } catch {
//                return []
//            }
//        }
//
//        func save() {
//            do {
//                let data = try JSONEncoder().encode(locations)
//                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
//            } catch {
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
//
//        func clearSavedLocations() {
//            locations = []
//            save()
//        }
//    }
// }
