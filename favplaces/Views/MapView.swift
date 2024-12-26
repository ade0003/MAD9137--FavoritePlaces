

import MapKit
import SwiftUI

struct MapView: View {
    @Binding var region: MapCameraPosition?
    let locations: [Location]
    var onLocationTap: (Location) -> Void
    var onMapTap: (CLLocationCoordinate2D) -> Void

    var body: some View {
        MapReader { proxy in
            Map(position: .constant(region ?? .automatic)) {
                UserAnnotation()
                ForEach(locations) { location in
                    Annotation(location.name, coordinate: location.coordinate) {
                        Image(systemName: "star.circle")
                            .resizable()
                            .foregroundStyle(.blue)
                            .frame(width: 44, height: 44)
                            .background(.white)
                            .clipShape(Circle())
                            .onLongPressGesture(minimumDuration: 0.2) {
                                onLocationTap(location)
                            }
                    }
                }
            }
            .onTapGesture { position in
                if let coordinate = proxy.convert(position, from: .local) {
                    onMapTap(coordinate)
                }
            }
        }
        .ignoresSafeArea()
    }
}
