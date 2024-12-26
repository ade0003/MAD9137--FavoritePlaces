

import MapKit
import SwiftUI

// this displays the map and handles map interactions

struct MapView: View {
    @Binding var region: MapCameraPosition?
    let locations: [Location]
    var onLocationTap: (Location) -> Void
    var onMapTap: (CLLocationCoordinate2D) -> Void

    var body: some View {
        MapReader { proxy in
            Map(position: .constant(region ?? .automatic)) {
                UserAnnotation()
                // this creates markers for each location

                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.blue)
                            .frame(width: 40, height: 40)
                            .background(.white)
                            .clipShape(Circle())
                            .onLongPressGesture(minimumDuration: 0.2) {
                                onLocationTap(location)
                            }
                            .allowsHitTesting(true)
                    }
                }
            }
            // this handles taps on the map

            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    onMapTap(coordinate)
                }
            }
        }
        .ignoresSafeArea()
    }
}
