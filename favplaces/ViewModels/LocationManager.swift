
import CoreLocation
import Foundation
import MapKit
import SwiftUI

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
    
    func requestLocation() {
        locationTimeout?.invalidate()
        
        if locationStatus == .authorizedWhenInUse || locationStatus == .authorizedAlways {
            locationManager.requestLocation()
            
            locationTimeout = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
                self?.handleLocationTimeout()
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func handleLocationTimeout() {
        print("Location request timed out")
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
        updateRegion(with: location)
        locationTimeout?.invalidate()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location error: \(error.localizedDescription)")
        if let lastLocation = userLocation {
            updateRegion(with: lastLocation)
        }
    }
}
