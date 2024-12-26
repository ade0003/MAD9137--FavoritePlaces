//
//  LocationManager.swift
//  favplaces
//
//  Created by Goodness Ade on 2024-12-26.
//
//
// import CoreLocation
// import Foundation
// import MapKit
// import SwiftUI
//
// class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//    private let locationManager = CLLocationManager()
//    @Published var region: MapCameraPosition?
//    @Published var locationStatus: CLAuthorizationStatus?
//
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    }
//
//    func requestLocation() {
//        if locationStatus == .authorizedWhenInUse || locationStatus == .authorizedAlways {
//            locationManager.requestLocation()
//        } else {
//            locationManager.requestWhenInUseAuthorization()
//        }
//    }
//
//
//    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
//        locationStatus = manager.authorizationStatus
//        switch manager.authorizationStatus {
//        case .authorizedWhenInUse, .authorizedAlways:
//            locationManager.requestLocation()
//        case .denied, .restricted:
//            print("Location access denied or restricted")
//        case .notDetermined:
//            locationManager.requestWhenInUseAuthorization()
//        @unknown default:
//            break
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        DispatchQueue.main.async {
//            self.region = MapCameraPosition.region(MKCoordinateRegion(
//                center: location.coordinate,
//                span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//            ))
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
//        print("Location manager failed with error: \(error.localizedDescription)")
//    }
// }

//
//  LocationManager.swift
//  favplaces
//
//  Created by sammy hutchinson on 2024-12-26.
//

import CoreLocation
import Foundation
import MapKit
import SwiftUI

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocation?

    private let locationManager = CLLocationManager()
    @Published var region: MapCameraPosition?
    @Published var locationStatus: CLAuthorizationStatus?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }

    func requestLocation() {
        if locationStatus == .authorizedWhenInUse || locationStatus == .authorizedAlways {
            locationManager.requestLocation()
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationStatus = manager.authorizationStatus
        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.requestLocation()
        case .denied, .restricted:
            print("Location access denied or restricted")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location

        DispatchQueue.main.async {
            withAnimation(.spring(duration: 0.5)) {
                self.region = MapCameraPosition.region(MKCoordinateRegion(
                    center: location.coordinate,
                    span: MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)
                ))
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
}
