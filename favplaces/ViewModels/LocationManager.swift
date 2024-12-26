
import CoreLocation
import Foundation
import MapKit
import SwiftUI

// this handles all location-related services and permissions
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var userLocation: CLLocation?
    @Published var region: MapCameraPosition?
    @Published var locationStatus: CLAuthorizationStatus?

    private let locationManager = CLLocationManager()
    private var locationTimeout: Timer?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationStatus = locationManager.authorizationStatus
    }

    // this requests continuous location updates with a timeout
    func requestLocation() {
        locationTimeout?.invalidate()

        if locationStatus == .authorizedWhenInUse || locationStatus == .authorizedAlways {
            locationManager.startUpdatingLocation() // use continuous updates

            // this creates a 2-second timeout
            locationTimeout = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] _ in
                self?.handleLocationTimeout()
                self?.locationManager.stopUpdatingLocation() // stop updates after timeout
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    // this handles when location request times out
    private func handleLocationTimeout() {
        print("location request timed out")
        if let lastLocation = userLocation {
            updateRegion(with: lastLocation)
        }
    }

    private func updateRegion(with location: CLLocation) {
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 0.8)) {
                let currentSpan = (self.region?.region as? MKCoordinateRegion)?.span ??
                    MKCoordinateSpan(latitudeDelta: 0.3, longitudeDelta: 0.3)

                self.region = MapCameraPosition.region(MKCoordinateRegion(
                    center: location.coordinate,
                    span: currentSpan
                ))
            }
        }
    }

    // this handles changes in location authorization
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationStatus = manager.authorizationStatus

        switch manager.authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation() // used continuous updates here
        case .denied, .restricted:
            print("location access denied or restricted")
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        @unknown default:
            break
        }
    }

    // this processes received location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = location
        updateRegion(with: location)
        locationTimeout?.invalidate()
        locationManager.stopUpdatingLocation() // stop updates after successful location
    }

    // this handles location errors gracefully
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location error: \(error.localizedDescription)")
        if let lastLocation = userLocation {
            updateRegion(with: lastLocation)
        }
        locationManager.stopUpdatingLocation() // stop updates on error
    }
}
